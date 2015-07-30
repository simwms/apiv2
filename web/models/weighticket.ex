defmodule Apiv2.Weighticket do
  use Apiv2.Web, :model

  schema "apiv2_weightickets" do
    field :pounds, :decimal
    field :license_plate, :string
    field :notes, :string
    field :finish_pounds, :decimal
    field :external_reference, :string
    belongs_to :issuser, Apiv2.Tile, foreign_key: :issuer_id
    belongs_to :finisher, Apiv2.Tile, foreign_key: :finisher_id
    belongs_to :appointment, Apiv2.Appointment, foreign_key: :appointment_id
    belongs_to :dock, Apiv2.Tile, foreign_key: :dock_id
    has_one :truck, Apiv2.Truck, foreign_key: :weighticket_id
    has_many :pictures, {"apiv2_weighticket_pictures", Apiv2.Picture}, foreign_key: :assoc_id
    timestamps 
  end

  @required_fields ~w(appointment_id issuer_id dock_id pounds)
  @optional_fields ~w(license_plate notes finisher_id finish_pounds external_reference)

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
