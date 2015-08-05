defmodule Apiv2.AppointmentTest do
  use Apiv2.ModelCase

  alias Apiv2.Appointment

  @valid_attrs %{
    appointment_type: "dropoff",
    company: "some content", 
    expected_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, 
    material_description: "some content", 
    notes: "some content"}
  @invalid_attrs %{}

  test "the hook should actually produce permalink" do
    Appointment.changeset(%Appointment{}, @valid_attrs) 
    |> Appointment.create_permalink
    |> Ecto.Changeset.get_field(:permalink)
    |> String.match?(~r/^some-content-/)
    |> assert
  end

  test "the hook should fire after insertion" do
    Appointment.changeset(%Appointment{}, @valid_attrs)
    |> Repo.insert!
    |> (fn appointment -> appointment.permalink end).()
    |> assert
  end

  test "changeset with valid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
