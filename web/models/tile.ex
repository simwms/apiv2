defmodule Apiv2.Tile do
  use Apiv2.Web, :model

  schema "apiv2_tiles" do
    field :tile_type, :string
    field :tile_name, :string
    field :status, :string
    field :x, :integer
    field :y, :integer
    field :z, :integer
    field :width, :decimal
    field :height, :decimal
    field :deleted_at, Ecto.DateTime

    has_many :cameras, Apiv2.Camera, foreign_key: :tile_id
    has_many :batches, Apiv2.Batch, foreign_key: :warehouse_id

    # Jose Valim says here https://groups.google.com/forum/#!topic/elixir-ecto/iTCBgv2ZhxQ
    # that he will look into building a has_many that supports queries... but until then,
    # I'll have to roll my own temporary solution
    # has_many :entering_trucks, Apiv2.Truck, foreign_key: :entry_scale_id
    # has_many :exiting_trucks, Apiv2.Truck, foreign_key: :exit_scale_id
    # has_many :loading_trucks, Apiv2.Truck, foreign_key: :dock_id
    association :many,
      :loading_trucks,
      Apiv2.HasManyScope,
      scope: Apiv2.TruckQuery.loading_trucks,
      foreign_key: :dock_id,
      queryable: Apiv2.Truck

    association :many,
      :exiting_trucks,
      Apiv2.HasManyScope,
      scope: Apiv2.TruckQuery.exiting_trucks,
      foreign_key: :exit_scale_id,
      queryable: Apiv2.Truck

    association :many,
      :entering_trucks,
      Apiv2.HasManyScope,
      scope: Apiv2.TruckQuery.entering_trucks,
      foreign_key: :entry_scale_id,
      queryable: Apiv2.Truck


    timestamps 
  end

  @required_fields ~w(tile_type x y)
  @optional_fields ~w(deleted_at tile_name status z width height)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
