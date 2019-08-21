defmodule BandstockEngine.TileGame.GameWorld do
  use GenServer

  alias Bandstock.Game
  alias Bandstock.Repo

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: :game_world)
  end

  def init(_state) do
    board = Game.get_board!(26) |>
    Repo.preload(:tiles)

    #IO.puts("board:")
    #IO.inspect(board) #TODOMFD "Hardcoded board id"

    #mat = Matrix.new([[%{color: "red"},%{color: "blue"},3],[4,5,6],[7,8,9]],3,3)

    {:ok, %{time: 1, board: board}}

  end

  def pulse(engine) do
    GenServer.call(engine, {:pulse})
  end

  def board_state() do
    GenServer.call({:board_state})
  end

  def scheduleAction(engine, action, delay) do
    GenServer.cast(engine, {:add, action, delay})
  end

  def doAction(engine, action) do
    GenServer.cast(engine, {:do, action})
  end

  # GenServer callbacks
  def handle_call({:say, msg}, _from, state) do
    {:reply, msg, state}
  end

  def handle_call({:board_state}, _from, state) do
    {:reply, state, state}
  end

  #send out the next batch of messages
  def handle_call({:pulse}, _from, state) do

    state = Map.update!(state, :time, &(&1 + 1))

    board = Map.get(state, :board)
    tiles = Map.get(board, :tiles)

    length = length(tiles)

    rand = Enum.random(0..length-1)

    #dir = :rand.uniform(8)
    dir = [2, 4, 6, 8] |> Enum.shuffle |> hd
    tile = Enum.at(tiles, rand)

    width = 10
    height = 10
    rand_x1 = tile.x
    rand_y1 = tile.y

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

    tile = %{tile | x: rand_x1}
    tile = %{tile | y: rand_y1}


    #tile.x = rand_x1
    #tile.y = rand_x2
    #TODOMFD: Put this modified tile back into the tiles list, which is inside the board object, which is inside the state object

    #put_in(state, [:board, :tiles])
    #state = Map.replace!(state, :tile, %{x: rand_x2, y: rand_y2})

    broadcast("swap", %{tile1: %{x: rand_x1, y: rand_y1}, tile2: %{x: rand_x2, y: rand_y2}});
    {:reply, "swap", state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp broadcast(type, body) do
    #IO.puts("broadcasting " <> type <> ":")
    #IO.inspect(body);

    #TODOMFD "Hardcoded board ID"
    #TODOMFDNEXT "Where is this going?"
    BandstockWeb.Endpoint.broadcast! "board:26", "board_output", %{
      type: type,
      body: body
  }
  end
end
