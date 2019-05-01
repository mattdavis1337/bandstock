defmodule Bandstock.Repo.Migrations.CreateTilePlacements do
  use Ecto.Migration

  def change do
    create table(:tile_placements) do
      add :hash, :string
      add :x, :integer
      add :y, :integer
      add :z, :integer
      add :type, :string

      timestamps()
    end

  end
end
