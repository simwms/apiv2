defmodule Apiv2.PageController do
  use Apiv2.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
