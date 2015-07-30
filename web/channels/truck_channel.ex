defmodule Apiv2.TruckChannel do
  use Apiv2.Web, :channel

  def join("trucks:adds", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("trucks:changes", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("trucks:removes", _auth_msg, socket) do
    {:ok, socket}
  end

end