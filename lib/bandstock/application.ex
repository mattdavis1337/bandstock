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
      BandstockEngine.TileGame.GameEngine,
      BandstockWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html

    opts = [strategy: :one_for_one, name: Application.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BandstockWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
