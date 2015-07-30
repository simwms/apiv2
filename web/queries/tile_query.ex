defmodule Apiv2.TileQuery do
  import Ecto.Query
  alias Apiv2.Tile

  @preload_fields ~w(cameras entering_trucks exiting_trucks loading_trucks batches)a
  @default_scope from t in Tile,
    select: t
  def index(params) do
    @default_scope
    |> consider_tile_types(params)
    |> preload(^@preload_fields)
  end

  def show(id) do
    from t in Tile,
      where: t.id == ^id,
      select: t,
      preload: ^@preload_fields 
  end

  def consider_tile_types(query, %{"type" => type}) do
    query
    |> where([t], t.tile_type == ^type)
  end
  def consider_tile_types(query, _), do: query
end