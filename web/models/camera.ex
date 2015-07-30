defmodule Apiv2.Camera do
  use Apiv2.Web, :model

  schema "apiv2_cameras" do
    field :permalink, :string
    field :camera_name, :string
    field :mac_address, :string
    field :camera_style, :string

    belongs_to :tile, Apiv2.Tile
    timestamps 
  end

  @required_fields ~w(camera_name tile_id camera_style)
  @optional_fields ~w(mac_address permalink)

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
