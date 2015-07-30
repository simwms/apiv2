defmodule Apiv2.Repo.Migrations.CreateBatchRelationships do
  use Ecto.Migration

  def change do
    create table(:apiv2_batch_relationships) do
      add :appointment_id, :integer
      add :batch_id, :integer
      add :notes, :string
      timestamps
    end
    create index(:apiv2_batch_relationships, [:appointment_id, :batch_id], unique: true)
    create index(:apiv2_batch_relationships, [:batch_id, :appointment_id], unique: true)
  end
end
