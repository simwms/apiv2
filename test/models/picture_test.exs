defmodule Apiv2.PictureTest do
  use Apiv2.ModelCase

  alias Apiv2.Picture

  @valid_attrs %{etag: "some content", key: "some content", location: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Picture.changeset(%Picture{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Picture.changeset(%Picture{}, @invalid_attrs)
    refute changeset.valid?
  end
end
