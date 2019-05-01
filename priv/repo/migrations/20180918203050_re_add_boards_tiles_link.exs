defmodule Bandstock.Repo.Migrations.ReAddBoardsTilesLink do
  use Ecto.Migration

  def change do
    create table(:tiles_boards) do
      add :tile_id, references(:tiles)
      add :board_id, references(:boards)
    end

    create unique_index(:tiles_boards, [:tile_id, :board_id])
  end
end
