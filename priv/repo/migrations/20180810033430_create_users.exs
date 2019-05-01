defmodule Bandstock.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :handle, :string
      add :provider, :string
      add :token, :string
      add :admin, :boolean, default: false, null: false
      add :hash, :string

      timestamps()
    end

  end
end
