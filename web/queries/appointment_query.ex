defmodule Apiv2.AppointmentQuery do
  import Ecto.Query
  alias Apiv2.Appointment
  @preload_fields [
    :truck, 
    :weighticket, 
    :batches, 
    :pickups,
    :dropoffs,
    outgoing_batches: :pickup_appointments
  ]

  def preload_fields, do: @preload_fields

  def build_pagination_query(query, params) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "10")
    query 
    |> limit([a], ^per_page)
    |> offset([a], ^((page - 1) * per_page))
  end

  def build_macro_query(query, params) do
    query
    |> expected_at_start(params["expected_at_start"])
    |> expected_at_finish(params["expected_at_finish"])
  end

  def expected_at_start(query, nil), do: query
  def expected_at_start(query, datetime) do
    query 
    |> where([a], a.expected_at > ^(Apiv2.TiExt.parse datetime))
  end
  def expected_at_finish(query, nil), do: query
  def expected_at_finish(query, datetime) do
    query 
    |> where([a], a.expected_at < ^(Apiv2.TiExt.parse datetime))
  end

  
  @default_index_query from a in Appointment,
    where: is_nil(a.deleted_at)

  def index(%{"everything" => _} = params) do
    @default_index_query
    |> build_pagination_query(params)
    |> select([a], a)
    |> order_by([a], desc: a.expected_at)
  end
  def index(params) do
    params
    |> index_core
    |> select([a], a)
    |> order_by([a], desc: a.expected_at)
  end

  def index_core(params) do
    @default_index_query
    |> consider_cancellation(params["cancelled_at"])
    |> consider_fulfillment(params["fulfilled_at"])
    |> consider_appointment_type(params)
    |> build_macro_query(params)
    |> build_pagination_query(params)
    |> consider_search(params)
  end

  def consider_appointment_type(query, %{"pickup" => "false"}) do
    query |> where([a], a.appointment_type != "pickup")
  end
  def consider_appointment_type(query, %{"pickup" => "true"}) do
    query |> where([a], a.appointment_type == "pickup")
  end
  def consider_appointment_type(query, _), do: query

  def consider_cancellation(query, "true"), do: query |> where([a], not is_nil(a.cancelled_at))
  def consider_cancellation(query, "false"), do: query |> where([a], is_nil(a.cancelled_at))
  def consider_cancellation(query, _), do: query

  def consider_fulfillment(query, "true"), do: query |> where([a], not is_nil(a.fulfilled_at))
  def consider_fulfillment(query, "false"), do: query |> where([a], is_nil(a.fulfilled_at))
  def consider_fulfillment(query, _), do: query

  def pagination(params) do
    params
    |> index_core
    |> select([a], count(a.id))
  end

  def show(%{"id" => id}) do
    query = from a in Appointment,
      select: a
    try do
      _ = String.to_integer(id)
      query |> where([a], a.id == ^id)
    rescue
      _ in ArgumentError ->
        query |> where([a], a.permalink == ^id)
    end
  end

  def consider_search(query, %{"search" => ""}), do: query
  def consider_search(query, %{"search" => search}) do
    import Apiv2.StrExt, only: [to_url: 1]
    query
    |> where([a], like(a.permalink, ^(p to_url search)) or 
                  like(a.company_permalink, ^(p to_url search)) or 
                  like(a.external_reference, ^(p search)))
  end
  def consider_search(query, _), do: query

  defp p(str), do: "%#{str}%"
end