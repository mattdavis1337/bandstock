defmodule Bandstock.Schema.Artist do
  use Ecto.Schema
  import Ecto.Changeset


  schema "artists" do
    field :facebook, :string
    field :name, :string
    has_one :board, Bandstock.Schema.Board
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :facebook])
    |> validate_required([:name, :facebook])
  end
end
