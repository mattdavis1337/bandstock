defmodule Bandstock.Repo.Migrations.UpdateTilesTableUniqueHash do
  use Ecto.Migration

  def change do
    create unique_index(:tiles, [:hash])
  end
end
