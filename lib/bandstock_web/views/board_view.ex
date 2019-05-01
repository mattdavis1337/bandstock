defmodule BandstockWeb.BoardView do
  use BandstockWeb, :view
  alias BandstockWeb.BoardView
  alias BandstockWeb.TileView
  alias Bandstock.Repo

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    board = Repo.preload(board, :tiles)

    %{id: board.id,
      name: board.name,
      hash: board.hash,
      tiles: TileView.render("index.json", %{tiles: board.tiles})}
  end
end
