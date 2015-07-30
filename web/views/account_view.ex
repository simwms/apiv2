defmodule Apiv2.AccountView do
  use Apiv2.Web, :view

  def render("index.json", %{accounts: accounts}) do
    %{accounts: render_many(accounts, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{account: render_one(account, "account.json")}
  end

  def render("account.json", %{account: account}) do
    account |> ember_attributes |> Apiv2.DictExt.reject_blank_keys
  end

  def ember_attributes(account) do
    %{
      id: account.id,
      email: account.email,
      access_key_id: account.access_key_id,
      secret_access_key: account.secret_access_key,
      region: account.region,
      namespace: account.namespace,
      timezone: account.timezone
    }
  end
end
