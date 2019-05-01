defmodule Bandstock.Repo.Migrations.DropTilePlacementColumns do
  use Ecto.Migration

  def change do
    alter table(:tile_placements) do
      remove :hash
      remove :x
      remove :y
      remove :z
      remove :type
    end
  end
end
