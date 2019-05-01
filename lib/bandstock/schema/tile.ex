defmodule Bandstock.Schema.Tile do
  use Arc.Ecto.Schema
  use Ecto.Schema
  import Ecto.Changeset

#tileimage references commented out with #TI prefix

  schema "tiles" do
    field :hash, :string
    field :name, :string
    field :x, :integer
    field :y, :integer
    field :z, :integer
    field :color, :string
    field :type, :string

    #TI field :tileimage, BandstockWeb.TileImage.Type
    many_to_many :boards, Bandstock.Schema.Board, join_through: "tiles_boards"
    timestamps()
  end

  @doc false
  def changeset(tile, attrs) do
    tile
    #TI |> cast(attrs, [:name, :hash, :color, :tileimage, :x, :y, :z, :type])
    |> cast(attrs, [:name, :hash, :color, :x, :y, :z, :type])
    #TI |> cast_attachments(attrs, [:tileimage])
    |> unique_constraint(:hash)
    #TI |> validate_required([:name, :hash, :color, :tileimage, :x, :y, :z, :type])
    |> validate_required([:name, :hash, :color, :x, :y, :z, :type])
  end
end
