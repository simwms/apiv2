defmodule Apiv2.EmployeeTest do
  use Apiv2.ModelCase

  alias Apiv2.Employee

  @valid_attrs %{arrived_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, email: "some content", full_name: "some content", left_work_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, phone: "some content", tile: nil, tile_type: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Employee.changeset(%Employee{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Employee.changeset(%Employee{}, @invalid_attrs)
    refute changeset.valid?
  end
end
