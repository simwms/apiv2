defmodule Apiv2.TileController do
  use Apiv2.Web, :controller
  alias Apiv2.Tile
  

  def index(conn, params) do
    tiles = params 
    |> Apiv2.TileQuery.index 
    |> Repo.all
    render conn, "index.json", tiles: tiles
  end

  def show(conn, %{"id" => id}) do
    tile = id
    |> Apiv2.TileQuery.show
    |> Repo.one!
    render conn, "show.json", tile: tile
  end

  def create(conn, %{"tile" => tile_params}) do
    changeset = Tile.changeset(%Tile{}, tile_params)

    if changeset.valid? do
      tile = Repo.insert(changeset)
      render(conn, "show.json", tile: tile)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "tile" => tile_params}) do
    tile = Repo.get!(Tile, id)
    changeset = Tile.changeset(tile, tile_params)

    if changeset.valid? do
      tile = Repo.update(changeset)
      render(conn, "show.json", tile: tile)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tile = Repo.get!(Tile, id)
    tile = Repo.delete(tile)
    render(conn, "show.json", tile: tile)
  end

end
