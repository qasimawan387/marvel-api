defmodule MarvelApi.Repo do
  use Ecto.Repo,
    otp_app: :marvel_api,
    adapter: Ecto.Adapters.Postgres
end
