defmodule Bandstock.Repo.Migrations.BidBelongsToTile do
  use Ecto.Migration

  def change do
    alter table(:bids) do
      add :tile_id, references(:tiles)
    end
  end
end
