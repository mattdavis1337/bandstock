defmodule Bandstock.Repo.Migrations.AddColorToTiles do
  use Ecto.Migration

  def change do
    alter table(:tiles) do
      add :color, :string
    end
  end
end
