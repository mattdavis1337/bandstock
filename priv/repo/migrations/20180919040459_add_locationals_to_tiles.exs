defmodule Bandstock.Repo.Migrations.AddLocationalsToTiles do
  use Ecto.Migration

  def change do
    alter table(:tiles) do
      add :x, :integer
      add :y, :integer
      add :z, :integer
      add :type, :string
    end
  end
end
