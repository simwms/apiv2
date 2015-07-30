defmodule Apiv2.Repo.Migrations.CreatePicture do
  use Ecto.Migration

  @picture_tables ~w(apiv2_weighticket_pictures apiv2_batch_pictures apiv2_employee_pictures)a
  def change do
    @picture_tables
    |> Enum.map(&change_picture_table_for/1)
  end

  defp change_picture_table_for(name) do
    create table(name) do
      add :assoc_id, :integer
      add :location, :string
      add :etag, :string
      add :key, :string
      timestamps
    end
    create index(name, [:assoc_id])
  end
end
