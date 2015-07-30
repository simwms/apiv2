defmodule Apiv2.Repo.Migrations.CreateAppointmentRelationships do
  use Ecto.Migration

  def change do
    create table(:apiv2_appointment_relationships) do
      add :pickup_id, :integer
      add :dropoff_id, :integer
      add :notes, :string
      timestamps
    end
    create index(:apiv2_appointment_relationships, [:pickup_id, :dropoff_id], unique: true)
    create index(:apiv2_appointment_relationships, [:dropoff_id, :pickup_id], unique: true)
  end
end
