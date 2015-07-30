defmodule Apiv2.EmployeeControllerTest do
  use Apiv2.ConnCase

  alias Apiv2.Employee
  @valid_attrs %{arrived_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, email: "some content", full_name: "some content", left_work_at: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, phone: "some content", tile: nil, tile_type: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, employee_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    employee = Repo.insert %Employee{}
    conn = get conn, employee_path(conn, :show, employee)
    assert json_response(conn, 200)["data"] == %{
      "id" => employee.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, employee_path(conn, :create), employee: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Employee, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, employee_path(conn, :create), employee: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    employee = Repo.insert %Employee{}
    conn = put conn, employee_path(conn, :update, employee), employee: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Employee, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    employee = Repo.insert %Employee{}
    conn = put conn, employee_path(conn, :update, employee), employee: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    employee = Repo.insert %Employee{}
    conn = delete conn, employee_path(conn, :delete, employee)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Employee, employee.id)
  end
end
