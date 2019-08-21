defmodule Bandstock.Artists do
  @moduledoc """
  The Artists context.
  """

  import Ecto.Query, warn: false
  alias Bandstock.Repo
  alias Bandstock.Schema.Artist
  alias Bandstock.Schema.Board
  alias Bandstock.Game


  @doc """
  Returns the list of artists.

  ## Examples

      iex> list_artists()
      [%Artist{}, ...]

  """
  def list_artists do
    Repo.all(Artist)
  end

  @doc """
  Gets a single artist.

  Raises `Ecto.NoResultsError` if the Artist does not exist.

  ## Examples

      iex> get_artist!(123)
      %Artist{}

      iex> get_artist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_artist!(id), do: Repo.get!(Artist, id)

  def get_artist_with_board!(id) do
    artist = Repo.one from artist in Bandstock.Schema.Artist,
      where: artist.id == ^id,
      preload: [{:board, :tiles}]
    end



  @doc """
  Creates a artist.

  ## Examples

      iex> create_artist(%{field: value})
      {:ok, %Artist{}}

      iex> create_artist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_artist(attrs \\ %{}) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a artist.

  ## Examples

      iex> update_artist(artist, %{field: new_value})
      {:ok, %Artist{}}

      iex> update_artist(artist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Artist.

  ## Examples

      iex> delete_artist(artist)
      {:ok, %Artist{}}

      iex> delete_artist(artist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_artist(%Artist{} = artist) do
    Repo.delete(artist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking artist changes.

  ## Examples

      iex> change_artist(artist)
      %Ecto.Changeset{source: %Artist{}}

  """
  def change_artist(%Artist{} = artist) do
    Artist.changeset(artist, %{})
  end

  # def link_artist_and_board(artist = %Artist{}, board = %Board{}) do
  #   IO.puts("In link_artist_and_board")
  #   board = Repo.preload(board, :tiles)
  #   #IO.inspect(tile);
  #   tiles = board.tiles ++ [tile]
  #               |> Enum.map(&Ecto.Changeset.change/1)
  #
  #   board
  #     |> Ecto.Changeset.change
  #     |> Ecto.Changeset.put_assoc(:tiles, tiles)
  #     |> Repo.update
  # end


  def gen_artists(attrs \\ %{}) do
    # {:ok, artist1_board} = Game.create_board(%{"name" => "UI369 Board", "hash" => Game.gen_hash()})
    # {:ok, artist2_board} = Game.create_board(%{"name" => "Apple Crisp Board", "hash" => Game.gen_hash()})
    #
    # {:ok, artist1_board_tile1} = Game.create_tile(%{"name" => "UI369 Tile1",  "hash" => Game.gen_hash(), "x" => 1, "y" => 1, "z" => 1, "color" => "#ff2627", "type" => "gen_tile"})
    # {:ok, artist1_board_tile2} = Game.create_tile(%{"name" => "UI369 Tile2",  "hash" => Game.gen_hash(), "x" => 2, "y" => 1, "z" => 1, "color" => "#ff8026", "type" => "gen_tile"})
    # {:ok, artist1_board_tile3} = Game.create_tile(%{"name" => "UI369 Tile3",  "hash" => Game.gen_hash(), "x" => 3, "y" => 1, "z" => 1, "color" => "#ffff26", "type" => "gen_tile"})
    #
    # {:ok, artist2_board_tile1} = Game.create_tile(%{"name" => "Apple Crisp Tile1",  "hash" => Game.gen_hash(), "x" => 1, "y" => 1, "z" => 1, "color" => "#38ff26", "type" => "gen_tile"})
    # {:ok, artist2_board_tile2} = Game.create_tile(%{"name" => "Apple Crisp Tile2",  "hash" => Game.gen_hash(), "x" => 2, "y" => 1, "z" => 1, "color" => "#26ffda", "type" => "gen_tile"})
    # {:ok, artist2_board_tile3} = Game.create_tile(%{"name" => "Apple Crisp Tile3",  "hash" => Game.gen_hash(), "x" => 3, "y" => 1, "z" => 1, "color" => "#26b6ff", "type" => "gen_tile"})
    #
    # Game.link_tile_and_board(artist1_board_tile1, artist1_board)
    # Game.link_tile_and_board(artist1_board_tile2, artist1_board)
    # Game.link_tile_and_board(artist1_board_tile3, artist1_board)
    # Game.link_tile_and_board(artist2_board_tile1, artist2_board)
    # Game.link_tile_and_board(artist2_board_tile2, artist2_board)
    # Game.link_tile_and_board(artist2_board_tile3, artist2_board)
    #{:ok, artist2} = create_artist(%{"name" => "Apple Crisp", "facebook" => "https://www.facebook.com/applecrisp"})

    {:ok, artist1} = create_artist(%{name: "UI369", facebook: "https://www.facebook.com/ui369"})
    artist1_board = Ecto.build_assoc(artist1, :board, %{name: "UI369 Board", hash: Game.gen_hash()})
                  |>Repo.insert!()

    artist1_board_tile1 = Ecto.build_assoc( artist1_board,
                                            :tiles,
                                            %{name: "UI369 Tile1", hash: Game.gen_hash(),
                                              x: 1, y: 1, z: 1, color: "#ff2627", type: "seed_gen_tile" })
                       |> Repo.insert!()

    artist1_board_tile2 = Ecto.build_assoc( artist1_board,
                                             :tiles,
                                             %{name: "UI369 Tile2", hash: Game.gen_hash(),
                                               x: 2, y: 1, z: 1, color: "#ff2627", type: "seed_gen_tile" })
                        |> Repo.insert!()

    artist1_board_tile3 = Ecto.build_assoc( artist1_board,
                                            :tiles,
                                            %{name: "UI369 Tile3", hash: Game.gen_hash(),
                                              x: 3, y: 1, z: 1, color: "#ff2627", type: "seed_gen_tile" })
                       |> Repo.insert!()

    Game.link_tile_and_board(artist1_board_tile1, artist1_board);
    Game.link_tile_and_board(artist1_board_tile2, artist1_board);
    Game.link_tile_and_board(artist1_board_tile3, artist1_board);

  end
end
