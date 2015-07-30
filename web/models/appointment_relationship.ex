defmodule Apiv2.AppointmentRelationship do
  use Apiv2.Web, :model

  schema "apiv2_appointment_relationships" do
    field :notes, :string
    belongs_to :dropoff, Apiv2.Appointment, foreign_key: :dropoff_id
    belongs_to :pickup, Apiv2.Appointment, foreign_key: :pickup_id

    timestamps
  end

  @required_fields ~w(dropoff_id pickup_id)
  @optional_fields ~w(notes)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
