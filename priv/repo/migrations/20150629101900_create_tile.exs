defmodule Apiv2.Repo.Migrations.CreateTile do
  use Ecto.Migration

  def up do
    create table(:apiv2_tiles) do
      add :tile_type, :string
      add :tile_name, :string
      add :status, :string
      add :x, :integer
      add :y, :integer
      add :z, :integer
      add :width, :decimal, precision: 10, scale: 6
      add :height, :decimal, precision: 10, scale: 6
      add :deleted_at, :datetime
      add :capacity, :integer

      timestamps
    end
    seed_tiles
  end

  def down do
    drop table(:apiv2_tiles)
  end

  @seeds [
    %{
      "tile_type" => "barn",
      "x" => 2,
      "y" => 1,
      "width" => 1.0,
      "height" => 1.0
    },
    %{
      "tile_type" => "warehouse",
      "x" => 2,
      "y" => 2,
      "width" => 1.0,
      "height" => 1.0
    },
    %{
      "tile_type" => "scale",
      "tile_name" => "entrance scale",
      "x" => 1,
      "y" => 0,
      "width" => 1.0,
      "height" => 1.0
    },
    %{
      "tile_type" => "road",
      "x" => 1,
      "y" => 1,
      "width" => 1.0,
      "height" => 1.0
    }
  ]
  defp seed_tiles do
    @seeds
    |> Enum.map(&insert_tile/1)
  end

  defp insert_tile(tile_params) do
    alias Apiv2.Repo
    alias Apiv2.Tile
    Tile.changeset(%Tile{}, tile_params)
    |> Repo.insert!
  end
end
