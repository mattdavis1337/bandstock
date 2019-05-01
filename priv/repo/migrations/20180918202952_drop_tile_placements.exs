defmodule Bandstock.Repo.Migrations.DropTilePlacements do
  use Ecto.Migration

  def change do
    drop_if_exists table("tile_placements")
  end
end
