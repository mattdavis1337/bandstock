# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bandstock,
  ecto_repos: [Bandstock.Repo]

# Configures the endpoint
config :bandstock, BandstockWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AyibkF6C+BR78Ql/JtZdUUB18Yz1bNtmD6A2aO7cKZFGWhXRk10zkrWbtCX0QQqF",
  render_errors: [view: BandstockWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bandstock.PubSub, adapter: Phoenix.PubSub.PG2]

config :arc,
  storage: Arc.Storage.Local, #Arc.Storage.S3, # or
  storage_dir: "uploads/now"
  #bucket: {:system, "AWS_S3_BUCKET"} # if using Amazon S3

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
