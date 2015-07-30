defmodule Apiv2.HasManyScope do
  import Ecto.Query, only: [from: 2, join: 4, distinct: 3, select: 3, where: 3]
  @behaviour Ecto.Association
  @on_delete_opts [:nothing, :fetch_and_delete, :nilify_all, :delete_all]
  defstruct [:cardinality, :field, :owner, :assoc, :owner_key, :assoc_key, :queryable, :on_delete, :scope]

  @doc false
  def struct(module, name, opts) do
    ref =
      cond do
        ref = opts[:references] ->
          ref
        primary_key = Module.get_attribute(module, :primary_key) ->
          elem(primary_key, 0)
        true ->
          raise ArgumentError, "need to set :references option for " <>
            "association #{inspect name} when model has no primary key"
      end

    unless Module.get_attribute(module, :ecto_fields)[ref] do
      raise ArgumentError, "model does not have the field #{inspect ref} used by " <>
        "association #{inspect name}, please set the :references option accordingly"
    end

    queryable = Keyword.fetch!(opts, :queryable)
    assoc = Ecto.Association.assoc_from_query(queryable)

    if opts[:through] do
      raise ArgumentError, "invalid association #{inspect name}. When using the :through " <>
                           "option, the model should not be passed as second argument"
    end

    on_delete = opts[:on_delete] || :nothing

    unless on_delete in @on_delete_opts do
      raise ArgumentError, "invalid :on_delete option for #{inspect name}. The only valid options" <>
                           " are `:nothing`, `:fetch_and_delete`, `:nilify_all` and `:delete_all`"
    end

    %__MODULE__{
      field: name,
      cardinality: Keyword.fetch!(opts, :cardinality),
      owner: module,
      assoc: assoc,
      owner_key: ref,
      assoc_key: opts[:foreign_key] || Ecto.Association.association_key(module, ref),
      queryable: queryable,
      on_delete: on_delete,
      scope: opts[:scope]
    }
  end

  @doc false
  def build(%{assoc: assoc, owner_key: owner_key, assoc_key: assoc_key,
              queryable: queryable}, struct, attributes) do
    assoc
    |> struct(attributes)
    |> Map.put(assoc_key, Map.get(struct, owner_key))
    |> Ecto.Association.merge_source(queryable)
  end

  @doc false
  def joins_query(refl) do
    from o in refl.owner,
      join: q in ^refl.queryable,
      on: field(q, ^refl.assoc_key) == field(o, ^refl.owner_key)
  end

  @doc false
  def assoc_query(refl, values) do
    (refl.scope || refl.queryable)
    |> where([x], field(x, ^refl.assoc_key) in ^values)
  end

  @doc false
  def preload_info(refl) do
    {:assoc, refl, refl.assoc_key}
  end
end