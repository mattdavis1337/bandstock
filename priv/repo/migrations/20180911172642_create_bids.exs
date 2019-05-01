defmodule Bandstock.Repo.Migrations.CreateBids do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :phone, :string
      add :piece, :string
      add :amount, :float
      add :comment, :string

      timestamps()
    end
  end
end
