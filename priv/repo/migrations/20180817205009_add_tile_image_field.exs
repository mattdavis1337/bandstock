defmodule Bandstock.Repo.Migrations.AddTileImageField do
  use Ecto.Migration

  def change do
    alter table(:tiles) do
      add :tileimage, :string
    end
  end
end
