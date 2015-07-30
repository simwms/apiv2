defmodule Apiv2.AppointmentChannel do
  use Apiv2.Web, :channel

  def join("appointments:adds", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("appointments:changes", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("appointments:removes", _auth_msg, socket) do
    {:ok, socket}
  end

end