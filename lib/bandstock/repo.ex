defmodule Bandstock.Repo do
  use Ecto.Repo,
    otp_app: :bandstock,
    adapter: Ecto.Adapters.Postgres
end
