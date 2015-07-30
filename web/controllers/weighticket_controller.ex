defmodule Apiv2.WeighticketController do
  use Apiv2.Web, :controller

  alias Apiv2.Weighticket
  alias Apiv2.WeighticketQuery, as: Q

  plug :scrub_params, "weighticket" when action in [:create, :update]
  
  def index(conn, _params) do
    weightickets = Repo.all(Weighticket) |> Repo.preload(Q.preload_fields)
    render(conn, "index.json", weightickets: weightickets)
  end

  def create(conn, %{"weighticket" => weighticket_params}) do
    changeset = Weighticket.changeset(%Weighticket{}, weighticket_params)

    if changeset.valid? do
      weighticket = Repo.insert!(changeset) |> Repo.preload(Q.preload_fields)
      render(conn, "show.json", weighticket: weighticket)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, params) do
    weighticket = params 
    |> Q.show 
    |> Repo.one!
    |> Repo.preload(Q.preload_fields)
    render conn, "show.json", weighticket: weighticket
  end

  def update(conn, %{"id" => id, "weighticket" => weighticket_params}) do
    weighticket = Repo.get!(Weighticket, id)
    changeset = Weighticket.changeset(weighticket, weighticket_params)

    if changeset.valid? do
      weighticket = Repo.update(changeset) |> Repo.preload(Q.preload_fields)
      render(conn, "show.json", weighticket: weighticket)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    weighticket = Repo.get!(Weighticket, id)

    weighticket = Repo.delete!(weighticket)
    render(conn, "show.json", weighticket: weighticket)
  end
end
