defmodule DungeonStats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DungeonStatsWeb.Telemetry,
      # Start the Ecto repository
      DungeonStats.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DungeonStats.PubSub},
      # Start Finch
      {Finch, name: DungeonStats.Finch},
      # Start the Endpoint (http/https)
      DungeonStatsWeb.Endpoint
      # Start a worker by calling: DungeonStats.Worker.start_link(arg)
      # {DungeonStats.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DungeonStats.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DungeonStatsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
