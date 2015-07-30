defmodule Apiv2.Account do
  use Apiv2.Web, :model

  schema "apiv2_accounts" do
    field :email, :string
    field :access_key_id, :string
    field :secret_access_key, :string
    field :region, :string
    field :namespace, :string
    field :timezone, :string

    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w(access_key_id secret_access_key region namespace timezone)

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
