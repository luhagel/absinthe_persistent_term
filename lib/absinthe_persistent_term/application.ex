defmodule AbsinthePersistentTerm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AbsinthePersistentTermWeb.Telemetry,
      AbsinthePersistentTerm.Repo,
      {DNSCluster,
       query: Application.get_env(:absinthe_persistent_term, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AbsinthePersistentTerm.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AbsinthePersistentTerm.Finch},
      # Start a worker by calling: AbsinthePersistentTerm.Worker.start_link(arg)
      # {AbsinthePersistentTerm.Worker, arg},
      {Absinthe.Schema, AbsinthePersistentTermWeb.Schema},
      # Start to serve requests, typically the last entry
      AbsinthePersistentTermWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AbsinthePersistentTerm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AbsinthePersistentTermWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
