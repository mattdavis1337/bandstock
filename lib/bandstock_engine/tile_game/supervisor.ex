defmodule BandstockEngine.TileGame.Supervisor do
  use DynamicSupervisor

  alias BandstockEngine.TileGame

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one);
  end

  def start_game(key) do
    IO.puts("starting game: " <> key);
    spec = {TileGame.PeriodicTask, name: GameEngine}
    #{:ok, _} = GenServer.start_link(MyApp, [:hello], name: :your_genserver_name)
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  #children = [
  #  worker(BandstockEngine.Engine, [[name: BandstockEngine.Engine]]),
  #  worker(BandstockEngine.PeriodicTask, [[name: BandstockEngine.PeriodicTask]])
  #]

  #supervise(children, strategy: :one_for_one)



end
