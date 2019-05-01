defmodule Bandstock.Repo.Migrations.RemoveBids do
  use Ecto.Migration

  def change do
    drop_if_exists table("bids")
  end
end
