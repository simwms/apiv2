defmodule Apiv2.ReportController do
  use Apiv2.Web, :controller
  alias Apiv2.ReportQuery
  def index(conn, params) do
    appointments = params |> ReportQuery.appointments |> Repo.all
    batches = params |> ReportQuery.batches |> Repo.all
    assigns = [
      start_at: params["start_at"],
      finish_at: params["finish_at"],
      appointments: appointments,
      batches: batches
    ]
    render(conn, "index.html", assigns)
  end
end