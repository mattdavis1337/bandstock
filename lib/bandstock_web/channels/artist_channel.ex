defmodule BandstockWeb.ArtistChannel do
  use Phoenix.Channel
  alias BandstockWeb.ArtistView
  alias Bandstock.Repo

  def join("artist:" <> artist_id, _params, socket) do
    IO.puts("[artist_channel.ex] received join artist:" <> artist_id)
    #state = GenServer.call(:game_world, {:board_state})

    artist = Bandstock.Artists.get_artist_with_board!(artist_id);
    reply = %{"artist" => ArtistView.render("show.json", %{artist: artist} )};
    {:ok, reply, socket}
  end

  def handle_in("channel_input", %{"body" => body}, socket) do
    IO.puts("[artist_channel.ex] received input artist_input");
    {:noreply, socket}
  end

  def handle_out("channel_out", _params, socket) do
    IO.puts("[board_channel.ex] handle_out");
  end
end
