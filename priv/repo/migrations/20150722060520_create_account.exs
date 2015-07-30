defmodule Apiv2.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def up do
    create table(:apiv2_accounts) do
      add :email, :string
      add :access_key_id, :string
      add :secret_access_key, :string
      add :region, :string
      add :namespace, :string
      add :timezone, :string

      timestamps
    end
    create index(:apiv2_accounts, [:email], unique: true)
    seed_accounts
  end

  def down do
    drop index(:apiv2_accounts, [:email], unique: true)
    drop table(:apiv2_accounts)
  end

  @seeds [
    %{
      "email" => "test-user@simwms.com",
      "access_key_id" => "AKIAINYEM24JX5TX33LA",
      "secret_access_key" => "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",
      "region" => "us-east-1",
      "namespace" => "test-user"
    }
  ]
  defp seed_accounts do
    @seeds
    |> Enum.map(&insert_account/1)
  end
  def insert_account(params) do
    alias Apiv2.Repo
    alias Apiv2.Account
    Account.changeset(%Account{}, params)
    |> Repo.insert!
  end
end
