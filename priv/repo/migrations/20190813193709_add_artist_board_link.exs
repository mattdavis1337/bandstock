defmodule Bandstock.Repo.Migrations.AddArtistBoardLink do
  use Ecto.Migration

  def change do
      alter table(:boards) do
        add :artist_id, references(:artists)
      end
  end
end
