defmodule Apiv2.Employee do
  use Apiv2.Web, :model

  schema "apiv2_employees" do
    field :full_name, :string
    field :title, :string
    field :tile_type, :string
    field :arrived_at, Ecto.DateTime
    field :left_work_at, Ecto.DateTime
    field :fired_at, Ecto.DateTime
    field :phone, :string
    field :email, :string
    belongs_to :tile, Apiv2.Tile
    has_many :pictures, {"apiv2_employee_pictures", Apiv2.Picture}, foreign_key: :assoc_id
    timestamps
  end

  @required_fields ~w(full_name email)
  @optional_fields ~w(title tile_type tile_id arrived_at left_work_at phone)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
