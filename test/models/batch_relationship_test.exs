defmodule Apiv2.BatchRelationshipTest do
  use Apiv2.ModelCase

  alias Apiv2.BatchRelationship

  @valid_attrs %{appointment: nil, batch: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = BatchRelationship.changeset(%BatchRelationship{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = BatchRelationship.changeset(%BatchRelationship{}, @invalid_attrs)
    refute changeset.valid?
  end
end
