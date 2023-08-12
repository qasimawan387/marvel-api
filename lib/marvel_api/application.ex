defmodule MarvelApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      MarvelApi.Repo,
      # Start the Telemetry supervisor
      MarvelApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MarvelApi.PubSub},
      # Start the Endpoint (http/https)
      MarvelApiWeb.Endpoint,
      # Start a worker by calling: MarvelApi.Worker.start_link(arg)
      # {MarvelApi.Worker, arg}
      Supervisor.child_spec({Cachex, name: :marvel_api_cache}, id: :marvel_api_cache)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MarvelApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarvelApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
