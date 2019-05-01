defmodule Bandstock.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Bandstock.Repo,
      # Start the endpoint when the application starts
      BandstockWeb.Endpoint,
      BandstockEngine.TileGame.Supervisor,
      {Registry, keys: :unique, name: BandstockEngine.Registry},
      # Starts a worker by calling: Bandstock.Worker.start_link(arg)
      # {Bandstock.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    #opts = [strategy: :one_for_one, name: Bandstock.Supervisor]
    #Supervisor.start_link(children, opts)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bandstock.TileGame.Supervisor]
    Supervisor.start_link(children, opts)

    BandstockEngine.TileGame.Supervisor.find_or_start_game("mainboard");
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BandstockWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
