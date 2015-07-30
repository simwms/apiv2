defmodule Apiv2.TruckController do
  use Apiv2.Web, :controller

  alias Apiv2.Truck

  plug :scrub_params, "truck" when action in [:create, :update]
  

  @preload_fields [:appointment, :weighticket, :batches]
  def index(conn, params) do
    trucks =  params 
    |> Apiv2.TruckQuery.index 
    |> Repo.all
    |> Repo.preload(@preload_fields)
    render(conn, "index.json", trucks: trucks)
  end

  def show(conn, %{"id" => id}) do
    truck = Repo.get(Truck, id) |> Repo.preload(@preload_fields)
    render conn, "show.json", truck: truck
  end

  def create(conn, %{"truck" => truck_params}) do
    changeset = Truck.changeset(%Truck{}, truck_params)

    if changeset.valid? do
      truck = Repo.insert(changeset) |> Repo.preload(@preload_fields)
      Apiv2.Endpoint.broadcast! "trucks:adds", "new", %{truck: truck}
      render(conn, "show.json", truck: truck)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end


  def update(conn, %{"id" => id, "truck" => truck_params}) do
    truck = Repo.get(Truck, id)
    changeset = Truck.changeset(truck, truck_params)

    if changeset.valid? do
      truck = Repo.update(changeset) |> Repo.preload(@preload_fields)
      Apiv2.Endpoint.broadcast! "trucks:changes", id, %{truck: truck}
      render(conn, "show.json", truck: truck)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    truck = Repo.get(Truck, id)

    truck = Repo.delete(truck)
    Apiv2.Endpoint.broadcast! "trucks:removes", id, %{truck: truck}
    render(conn, "show.json", truck: truck)
  end
end