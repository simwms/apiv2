defmodule Apiv2.AppointmentQueryTest do
  use Apiv2.ModelCase
  alias Apiv2.AppointmentQuery

  @simple_index %{
    "expected_at_finish" => "2015-08-04T20:00:00-07:00",
    "expected_at_start" => "2015-08-04T06:00:00-07:00"
  }
  test "index should work on a standard query" do
    appointments = @simple_index
    |> AppointmentQuery.index
    |> Repo.all
    assert appointments == []
  end

  test "pagination should work properly" do
    results = @simple_index
    |> AppointmentQuery.pagination
    |> Repo.one
    assert results == 0
  end

end