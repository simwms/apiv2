defmodule Apiv2.AppointmentMetaTest do
  use Apiv2.ModelCase
  alias Apiv2.AppointmentMeta

  @simple_index %{
    "expected_at_finish" => "2015-08-04T20:00:00-07:00",
    "expected_at_start" => "2015-08-04T06:00:00-07:00"
  }
  test "count should count" do
    k = @simple_index |> AppointmentMeta.count
    assert k == 0
  end

end