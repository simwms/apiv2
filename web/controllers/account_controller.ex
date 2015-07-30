defmodule Apiv2.AccountController do
  use Apiv2.Web, :controller

  alias Apiv2.Account

  plug :scrub_params, "account" when action in [:create, :update]

  def index(conn, _params) do
    accounts = Repo.all(Account)
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    if changeset.valid? do
      account = Repo.insert!(changeset)
      render(conn, "show.json", account: account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => _}) do
    query = from a in Account,
      limit: 1,
      select: a
    account = Repo.one!(query)
    render conn, "show.json", account: account
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account, account_params)

    if changeset.valid? do
      account = Repo.update!(changeset)
      render(conn, "show.json", account: account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Apiv2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)

    account = Repo.delete!(account)
    render(conn, "show.json", account: account)
  end
end
