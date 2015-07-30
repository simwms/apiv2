defmodule Apiv2.AppointmentRelationshipControllerTest do
  use Apiv2.ConnCase

  alias Apiv2.AppointmentRelationship
  @valid_attrs %{dropoff: nil, notes: "some content", pickup: nil}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, appointment_relationship_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    appointment_relationship = Repo.insert! %AppointmentRelationship{}
    conn = get conn, appointment_relationship_path(conn, :show, appointment_relationship)
    assert json_response(conn, 200)["data"] == %{
      "id" => appointment_relationship.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, appointment_relationship_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, appointment_relationship_path(conn, :create), appointment_relationship: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(AppointmentRelationship, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, appointment_relationship_path(conn, :create), appointment_relationship: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    appointment_relationship = Repo.insert! %AppointmentRelationship{}
    conn = put conn, appointment_relationship_path(conn, :update, appointment_relationship), appointment_relationship: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(AppointmentRelationship, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    appointment_relationship = Repo.insert! %AppointmentRelationship{}
    conn = put conn, appointment_relationship_path(conn, :update, appointment_relationship), appointment_relationship: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    appointment_relationship = Repo.insert! %AppointmentRelationship{}
    conn = delete conn, appointment_relationship_path(conn, :delete, appointment_relationship)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(AppointmentRelationship, appointment_relationship.id)
  end
end
