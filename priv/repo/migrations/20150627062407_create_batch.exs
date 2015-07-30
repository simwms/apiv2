defmodule Apiv2.Repo.Migrations.CreateBatch do
  use Ecto.Migration

  def up do
    create table(:apiv2_batches) do
      add :outgoing_count, :integer, default: 0, null: false
      add :permalink, :string
      add :description, :string
      add :quantity, :string
      add :deleted_at, :datetime
      add :dock_id, :integer
      add :appointment_id, :integer
      add :warehouse_id, :integer
      add :truck_id, :integer

      timestamps
    end
    create index(:apiv2_batches, [:dock_id])
    create index(:apiv2_batches, [:appointment_id])
    create index(:apiv2_batches, [:warehouse_id])
    create index(:apiv2_batches, [:truck_id])
    seed_batches
  end

  def down do
    drop index(:apiv2_batches, [:dock_id])
    drop index(:apiv2_batches, [:appointment_id])
    drop index(:apiv2_batches, [:warehouse_id])
    drop index(:apiv2_batches, [:truck_id])
    drop table(:apiv2_batches)
  end

  @seeds [%{
    "permalink" => "basic-seed-001",
    "description" => "test batch",
    "quantity" => "some amount",
    "appointment_id" => 1,
    "dock_id" => 1,
    "warehouse_id" => 2
  }, %{
    "permalink" => "basic-seed-002",
    "description" => "test batch",
    "quantity" => "some amount",
    "appointment_id" => 1,
    "dock_id" => 1,
    "warehouse_id" => 2
  }, %{
    "permalink" => "basic-seed-003",
    "description" => "test batch",
    "quantity" => "some amount",
    "appointment_id" => 1,
    "dock_id" => 1,
    "warehouse_id" => 2
  }]
  defp seed_batches do
    @seeds
    |> Enum.map(&insert_batch/1)
  end

  defp insert_batch(batch_params) do
    alias Apiv2.Repo
    alias Apiv2.Batch
    Batch.changeset(%Batch{}, batch_params)
    |> Repo.insert!
  end
end
