defmodule Apiv2.Repo.Migrations.CreateEmployee do
  use Ecto.Migration

  def change do
    create table(:apiv2_employees) do
      add :full_name, :string
      add :title, :string
      add :tile_type, :string
      add :arrived_at, :datetime
      add :left_work_at, :datetime
      add :fired_at, :datetime
      add :phone, :string
      add :email, :string
      add :tile_id, :integer

      timestamps
    end
    create index(:apiv2_employees, [:tile_id])
    create index(:apiv2_employees, [:email], unique: true)
  end
end
