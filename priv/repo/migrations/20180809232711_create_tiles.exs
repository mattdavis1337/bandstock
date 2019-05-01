defmodule Bandstock.Repo.Migrations.CreateTiles do
  use Ecto.Migration

  def change do
    create table(:tiles) do
      add :name, :string
      add :hash, :string

      timestamps()
    end

  end
end
