defmodule Apiv2.BatchRelationship do
  use Apiv2.Web, :model

  schema "apiv2_batch_relationships" do
    belongs_to :batch, Apiv2.Batch
    belongs_to :appointment, Apiv2.Appointment
    field :notes, :string
    timestamps
  end

  @required_fields ~w(batch_id appointment_id)
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
