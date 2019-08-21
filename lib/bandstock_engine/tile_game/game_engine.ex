defmodule BandstockEngine.TileGame.GameEngine do
  use GenServer

  alias BandstockEngine.TileGame

  @timeout 500  #repeat every X ms

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: :game_engine)
  end

  def init(_) do
    {:ok, world} = TileGame.GameWorld.start_link([])
    {:ok, %{world: world, clock: {System.monotonic_time(), 0} }, @timeout}
  end

  def handle_info(:timeout, state) do
    {prevTime, elapsed} = state.clock;
    time = System.monotonic_time(:millisecond);
    GenServer.call(:game_world, {:say, time})
    #GenServer.call(:game_world, {:pulse})

    #TileGame.Engine.pulse(state.engine);

    #GenServer.cast(state.engine, {:say, {time, time-prevTime}})
    #state = Map.replace!(state, :clock, {time, time-prevTime});
    #BandstockEngine.Engine.say(state.engine, "yes")

    {:noreply, state, @timeout}
  end
end
