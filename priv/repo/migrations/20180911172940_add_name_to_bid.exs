defmodule Bandstock.Repo.Migrations.AddNameToBid do
  use Ecto.Migration

  def change do
    alter table(:bids) do
      add :name, :string
    end
  end
end
