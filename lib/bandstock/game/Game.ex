defmodule Bandstock.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias Bandstock.Repo
  alias Bandstock.Schema.Board
  alias Bandstock.Schema.Tile

  #alias BandstockApi.Game.Tile
  #alias BandstockAPI.TileImage

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id)

  def gen_board(attrs \\ %{}) do
    IO.inspect("Generating board");
    IO.inspect(attrs)
    #Bandstock.Identicon.main("matt");
    {:ok, board} = create_board(%{"name" => "Generated Board" <> random_string(5), "hash" => gen_hash()})
    {:ok, tile1} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 1, "y" => 1, "z" => 1, "color" => "#ff2627", "type" => "gen_tile"})
    {:ok, tile2} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 2, "y" => 1, "z" => 1, "color" => "#ff8026", "type" => "gen_tile"})
    {:ok, tile3} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 3, "y" => 1, "z" => 1, "color" => "#ffff26", "type" => "gen_tile"})
    {:ok, tile4} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 4, "y" => 1, "z" => 1, "color" => "#38ff26", "type" => "gen_tile"})
    {:ok, tile5} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 1, "y" => 2, "z" => 1, "color" => "#26ffda", "type" => "gen_tile"})
    {:ok, tile6} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 2, "y" => 2, "z" => 1, "color" => "#26b6ff", "type" => "gen_tile"})
    {:ok, tile7} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 3, "y" => 2, "z" => 1, "color" => "#2626ff", "type" => "gen_tile"})
    {:ok, tile8} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 4, "y" => 2, "z" => 1, "color" => "#b626ff", "type" => "gen_tile"})
    {:ok, tile9} = create_tile(%{"name" => "Generated Tile" <> random_string(5),  "hash" => gen_hash(), "x" => 5, "y" => 2, "z" => 1, "color" => "#ff26b3", "type" => "gen_tile"})

    link_tile_and_board(tile1, board)
    link_tile_and_board(tile2, board)
    link_tile_and_board(tile3, board)
    link_tile_and_board(tile4, board)
    link_tile_and_board(tile5, board)
    link_tile_and_board(tile6, board)
    link_tile_and_board(tile7, board)
    link_tile_and_board(tile8, board)
    link_tile_and_board(tile9, board)
  end

  def create_board(attrs \\ %{}) do
    IO.inspect("in Game.create_board")
    IO.inspect(attrs);
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  def create_tile(attrs \\ %{}) do
    IO.inspect("in Game.create_tile")
    %Tile{}
    |> Tile.changeset(attrs)
    |> Repo.insert
  end


  def link_tile_and_board(tile = %Tile{}, board = %Board{}) do
    IO.puts("In link_tile_and_board")
    board = Repo.preload(board, :tiles)
    #IO.inspect(tile);
    tiles = board.tiles ++ [tile]
                |> Enum.map(&Ecto.Changeset.change/1)

    board
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:tiles, tiles)
      |> Repo.update
  end

  def unlink_tile_and_board(tile = %Tile{}, board = %Board{}) do
    board = Repo.preload(board, :tiles)
    tiles = board.tiles ++ [tile]
                |> Enum.map(&Ecto.Changeset.change/1)

    board
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:tiles, tiles)
    |> Repo.update
  end

  defp gen_hash() do
    random_string(8)
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.encode16 |> binary_part(0, length);
  end

end
