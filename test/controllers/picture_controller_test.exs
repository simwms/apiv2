defmodule Apiv2.PictureControllerTest do
  use Apiv2.ConnCase

  alias Apiv2.Picture
  @valid_attrs %{etag: "some content", key: "some content", location: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, picture_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = get conn, picture_path(conn, :show, picture)
    assert json_response(conn, 200)["data"] == %{
      "id" => picture.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, picture_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, picture_path(conn, :create), picture: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Picture, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, picture_path(conn, :create), picture: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = put conn, picture_path(conn, :update, picture), picture: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Picture, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = put conn, picture_path(conn, :update, picture), picture: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = delete conn, picture_path(conn, :delete, picture)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Picture, picture.id)
  end
end
