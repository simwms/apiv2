defmodule Apiv2.AppointmentMeta do
  alias Apiv2.Repo
  alias Apiv2.AppointmentQuery

  def generate(params) do
    %{
      total_pages: total_pages(params),
      count: count(params),
      current_page: current_page(params)
    }
  end

  def current_page(%{"page" => page}) when is_integer(page) do page end
  def current_page(%{"page" => page}) do
    {p, _} = Integer.parse(page)
    p
  end
  def current_page(_), do: 1

  def total_pages(params) do
    count(params) / per_page(params)
    |> trunc
  end

  def per_page(%{"per_page" => pp}) when is_integer(pp) do pp end
  def per_page(%{"per_page" => pp}) do
    {p, _} = Integer.parse(pp)
    p
  end
  def per_page(_), do: 10

  def count(params) do
    params |> AppointmentQuery.pagination |> Repo.one
  end

end