defmodule BandstockWeb.ArtistView do
  use BandstockWeb, :view
  alias BandstockWeb.ArtistView
  alias BandstockWeb.BoardView
  alias Bandstock.Repo

  def render("index.json", %{artists: artists}) do
    IO.puts("In artist render index")
    %{data: render_many(artists, ArtistView, "artist.json")}
  end

  def render("show.json", %{artist: artist}) do
    IO.puts("In artist render show")
    %{data: render_one(artist, ArtistView, "artist.json")}
  end

  def render("artist.json", %{artist: artist}) do
    IO.puts("In artist render board")
    artist = Repo.preload(artist, :board)

    %{id: artist.id,
      name: artist.name,
      facebook: artist.facebook,
      board: BoardView.render("board.json", %{board: artist.board})}
  end

end
