defmodule BandstockEngine.TileGame.Engine do
  use GenServer

  alias Bandstock.Game
  alias Bandstock.Repo

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_state) do
    board = Game.get_board!(26) |>
    Repo.preload(:tiles)

    IO.puts("board:")
    IO.inspect(board) #TODOMFD "Hardcoded board id"

    #mat = Matrix.new([[%{color: "red"},%{color: "blue"},3],[4,5,6],[7,8,9]],3,3)

    {:ok, %{time: 1, tile: %{x: 5, y: 5}}}
  end

  def pulse(engine) do
    GenServer.cast(engine, {:pulse})
  end

  def scheduleAction(engine, action, delay) do
    GenServer.cast(engine, {:add, action, delay})
  end

  def doAction(engine, action) do
    GenServer.cast(engine, {:do, action})
  end

  # GenServer callbacks

  def handle_call({:say, msg}, _from, state) do
    IO.inspect(msg);
    {:reply, msg, state}
  end

  #send out the next batch of messages
  def handle_cast({:pulse}, state) do
    width = 10;
    height = 10;
    tile = Map.get(state, :tile)
    rand_x1 = Map.get(tile, :x)
    rand_y1 = Map.get(tile, :y)

    #dir = :rand.uniform(8)
    dir = [2, 4, 6, 8] |> Enum.shuffle |> hd

    state = Map.update!(state, :time, &(&1 + 1))

    #rand_x2 =
    #  case {dir, rand_x1} do
    #      {4, left} when left != 0 -> rand_x1 - 1
    #      {6, right} when right != width -> rand_x1 + 1
    #      _ -> rand_x1
    #    end

rand_x2 =
    case dir do
      4 -> if rand_x1 == 0, do: rand_x1, else: rand_x1-1
      6 -> if rand_x1 == width, do: rand_x1, else: rand_x1+1
      _ -> rand_x1
    end

rand_y2 =
    case dir do
      2 -> if rand_y1 == 0, do: rand_y1, else: rand_y1-1
      8 -> if rand_y1 == height, do: rand_y1, else: rand_y1+1
      _ -> rand_y1
    end

    state = Map.replace!(state, :tile, %{x: rand_x2, y: rand_y2})

    broadcast("swap", %{tile1: %{x: rand_x1, y: rand_y1}, tile2: %{x: rand_x2, y: rand_y2}});
    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp broadcast(type, body) do
    IO.puts("broadcasting " <> type <> ":")
    IO.inspect(body);

    #TODOMFD "Hardcoded board ID"
    #TODOMFDNEXT "Where is this going?"
    BandstockWeb.Endpoint.broadcast! "board:26", "board_output", %{
      type: type,
      body: body
  }
  end
end
