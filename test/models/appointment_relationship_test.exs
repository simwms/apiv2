defmodule Apiv2.AppointmentRelationshipTest do
  use Apiv2.ModelCase

  alias Apiv2.AppointmentRelationship

  @valid_attrs %{dropoff: nil, notes: "some content", pickup: nil}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AppointmentRelationship.changeset(%AppointmentRelationship{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AppointmentRelationship.changeset(%AppointmentRelationship{}, @invalid_attrs)
    refute changeset.valid?
  end
end
