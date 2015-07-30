defmodule Apiv2.AccountTest do
  use Apiv2.ModelCase

  alias Apiv2.Account

  @valid_attrs %{access_key_id: "some content", namespace: "some content", region: "some content", secret_access_key: "some content", timezone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
