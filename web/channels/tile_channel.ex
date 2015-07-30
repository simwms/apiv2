defmodule Apiv2.TileChannel do
  use Apiv2.Web, :channel

  def join("tiles:adds", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("tiles:changes", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("tiles:removes", _auth_msg, socket) do
    {:ok, socket}
  end

end