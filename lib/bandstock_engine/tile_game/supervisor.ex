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
    spec = {TileGame.PeriodicTask, name: {:via, Registry, {BandstockEngine.Registry, key}}}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def game_exists?(key) do
    match?({:ok, _game}, lookup(key))
  end

  def find_game(key) do
    lookup(key)
  end

  def find_or_start_game(key) do
    case lookup(key) do
      {:ok, game} ->
        {:ok, game}

      :error ->
        start_game(key)
    end
  end

  defp lookup(key) do
    case Registry.lookup(BandstockEngine.Registry, key) do
      [{game, _nil}] -> {:ok, game}
      _ -> :error
    end
  end

  #children = [
  #  worker(BandstockEngine.Engine, [[name: BandstockEngine.Engine]]),
  #  worker(BandstockEngine.PeriodicTask, [[name: BandstockEngine.PeriodicTask]])
  #]

  #supervise(children, strategy: :one_for_one)



end
