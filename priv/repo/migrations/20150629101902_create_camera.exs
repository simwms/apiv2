defmodule Apiv2.Repo.Migrations.CreateCamera do
  use Ecto.Migration

  def change do
    create table(:apiv2_cameras) do
      add :permalink, :string
      add :camera_name, :string
      add :mac_address, :string
      add :camera_style, :string
      add :tile_id, :integer
      timestamps
    end
    create index(:apiv2_cameras, [:tile_id])
  end
end
