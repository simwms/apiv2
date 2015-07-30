defmodule Apiv2.Picture do
  use Apiv2.Web, :model

  schema "abstract table: pictures" do
    field :assoc_id, :integer
    field :location, :string
    field :etag, :string
    field :key, :string

    timestamps
  end

  @required_fields ~w(location assoc_id)
  @optional_fields ~w(etag key)

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
