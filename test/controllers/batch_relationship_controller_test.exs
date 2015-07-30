defmodule Apiv2.BatchRelationshipControllerTest do
  use Apiv2.ConnCase

  alias Apiv2.BatchRelationship
  @valid_attrs %{appointment: nil, batch: nil}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, batch_relationship_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    batch_relationship = Repo.insert! %BatchRelationship{}
    conn = get conn, batch_relationship_path(conn, :show, batch_relationship)
    assert json_response(conn, 200)["data"] == %{
      "id" => batch_relationship.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, batch_relationship_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, batch_relationship_path(conn, :create), batch_relationship: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(BatchRelationship, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, batch_relationship_path(conn, :create), batch_relationship: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    batch_relationship = Repo.insert! %BatchRelationship{}
    conn = put conn, batch_relationship_path(conn, :update, batch_relationship), batch_relationship: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(BatchRelationship, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    batch_relationship = Repo.insert! %BatchRelationship{}
    conn = put conn, batch_relationship_path(conn, :update, batch_relationship), batch_relationship: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    batch_relationship = Repo.insert! %BatchRelationship{}
    conn = delete conn, batch_relationship_path(conn, :delete, batch_relationship)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(BatchRelationship, batch_relationship.id)
  end
end
