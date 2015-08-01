defmodule Apiv2.TileQuery do
  import Ecto.Query
  alias Apiv2.Tile
  alias Apiv2.TruckQuery

  @preload_fields [:cameras, :batches,
    loading_trucks: TruckQuery.loading_trucks,
    exiting_trucks: TruckQuery.exiting_trucks,
    entering_trucks: TruckQuery.entering_trucks]

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