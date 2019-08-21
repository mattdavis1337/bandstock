defmodule BandstockWeb.BoardView do
  use BandstockWeb, :view
  alias BandstockWeb.BoardView
  alias BandstockWeb.TileView
  alias Bandstock.Repo

  def render("index.json", %{boards: boards}) do
    IO.puts("In board render index")
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    IO.puts("In board render show")
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    IO.puts("In board render board")
    board = Repo.preload(board, :tiles)

    %{id: board.id,
      name: board.name,
      hash: board.hash,
      tiles: TileView.render("index.json", %{tiles: board.tiles})}
  end
end
