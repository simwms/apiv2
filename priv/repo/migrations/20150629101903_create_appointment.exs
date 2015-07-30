defmodule Apiv2.Repo.Migrations.CreateAppointment do
  use Ecto.Migration

  def up do
    create table(:apiv2_appointments) do
      add :appointment_type, :string
      add :permalink, :string
      add :deleted_at, :datetime
      add :material_description, :string
      add :material_permalink, :string
      add :company, :string
      add :company_permalink, :string
      add :notes, :text
      add :fulfilled_at, :datetime
      add :cancelled_at, :datetime
      add :expected_at, :datetime
      add :exploded_at, :datetime
      add :external_reference, :string
      add :coupled_at, :datetime
      add :consumed_at, :datetime

      timestamps
    end
    create index(:apiv2_appointments, [:permalink])
    seed_appointments
  end

  def down do
    drop index(:apiv2_appointments, [:permalink])
    drop table(:apiv2_appointments)
  end

  @seeds [%{
    "appointment_type" => "dropoff",
    "material_description" => "test appointment material",
    "company" => "seed test company",
    "expected_at" => Ecto.DateTime.local,
    "fulfilled_at" => Ecto.DateTime.local
  }, %{
    "appointment_type" => "dropoff",
    "material_description" => "not a real material",
    "company" => "base test inc",
    "expected_at" => Ecto.DateTime.local,
    "fulfilled_at" => Ecto.DateTime.local
  }]

  defp seed_appointments do
    @seeds
    |> Enum.map(&insert_appointment/1)
  end

  defp insert_appointment(appointment_params) do
    alias Apiv2.Repo
    alias Apiv2.Appointment
    Appointment.changeset(%Appointment{}, appointment_params)
    |> Repo.insert!
  end
end
