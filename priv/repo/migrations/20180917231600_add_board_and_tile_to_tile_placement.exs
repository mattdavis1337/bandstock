defmodule Bandstock.Repo.Migrations.AddBoardAndTileToTilePlacement do
  use Ecto.Migration

  def change do
    alter table(:tile_placements) do
      add :tile_id, references(:tiles)
      add :board_id, references(:boards)
    end
  end
end
