defmodule BandstockWeb.TileView do
  use BandstockWeb, :view
  alias BandstockWeb.TileView
  alias BandstockWeb.TileImage


  def render("index.json", %{tiles: tiles}) do
    IO.puts("In render(index.json)");
    render_many(tiles, TileView, "tile.json")
  end

  def render("show.json", %{tile: tile}) do
    IO.puts("In render(show.json)");
    %{data: render_one(tile, TileView, "tile.json")}
  end

  def render("tile.json", %{tile: tile}) do
    IO.puts("In render(tile.json)");
    #TI file_name = tile.tileimage[:file_name]

    #TI original_url = TileImage.url({file_name, tile}, :original);
    #TI original_url = String.slice(original_url, String.length("/priv/static"), String.length(original_url));
    #TI thumb_url = TileImage.url({file_name, tile}, :thumb);
    #TI thumb_url = String.slice(thumb_url, String.length("/priv/static"), String.length(thumb_url));
    #Map.replace!(tile, "tileimage", TileImage.url({}));
    %{name: tile.name,
      hash: tile.hash,
      x: tile.x,
      y: tile.y,
      z: tile.z,
      color: tile.color,
      type: tile.type,}
      #TI image_full: original_url,
      #TI image_thumb: thumb_url}
  end
end
