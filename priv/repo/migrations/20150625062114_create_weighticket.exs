defmodule Apiv2.Repo.Migrations.CreateWeighticket do
  use Ecto.Migration

  def change do
    create table(:apiv2_weightickets) do
      add :appointment_id, :integer
      add :dock_id, :integer
      add :issuer_id, :integer
      add :finisher_id, :integer
      add :license_plate, :string
      add :notes, :text
      add :pounds, :decimal, precision: 15, scale: 2
      add :finish_pounds, :decimal, precision: 15, scale: 2
      add :external_reference, :string

      timestamps
    end
    create index(:apiv2_weightickets, [:appointment_id])
    create index(:apiv2_weightickets, [:dock_id])
  end
end
