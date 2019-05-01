defmodule Bandstock.Schema.Board do
  use Ecto.Schema
  import Ecto.Changeset


  schema "boards" do
    field :hash, :string
    field :name, :string
    many_to_many :tiles, Bandstock.Schema.Tile, join_through: "tiles_boards"
    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :hash])
    |> validate_required([:name, :hash])
  end
end
