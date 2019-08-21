defmodule BandstockWeb.BoardChannel do
  use Phoenix.Channel
  alias Bandstock.Repo
  alias BandstockWeb.BoardView
  alias BandstockEngine.TileGame.Engine

  #join returns {:ok, socket} or {:ok, reply, socket}. To deny access, we return {:error, reply}.

  def join("board:*", _message, socket) do
    IO.puts("[board_channel.ex] Joining Board")
    IO.inspect(_message)
    IO.inspect(socket)
    {:ok, socket}
  end

  def join("board:lobby", _message, socket) do
    IO.puts("[board_channel.ex] in join board:lobby")
    {:ok, socket}
  end

  def join("board:" <> board_id, _params, socket) do
    state = GenServer.call(:game_world, {:board_state})
    reply = %{"board" => BoardView.render("show.json", state)};
    IO.puts("board reply:");
    IO.inspect(reply);
    {:ok, reply, socket}
  end

  def handle_out("board:" <> board_id, _params, socket) do
    IO.puts("[board_channel.ex] handle_out");
  end

  def handle_in("board_input", %{"body" => body}, socket) do
    IO.puts("[board_channel.ex] received board_input");
    random_number = :rand.uniform(11)
    rand_x1 = :rand.uniform(10)
    rand_y1 = :rand.uniform(10)
    rand_x2 = :rand.uniform(10)
    rand_y2 = :rand.uniform(10)
    broadcast! socket, "board_output", %{type: "swap", body: body <> "-" <> Integer.to_string(random_number), x1: rand_x1, y1: rand_y1, x2: rand_x2,y2: rand_y2}
    {:noreply, socket}
  end
end
