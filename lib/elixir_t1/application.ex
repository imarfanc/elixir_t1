defmodule ElixirT1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirT1Web.Telemetry,
      {DNSCluster, query: Application.get_env(:elixir_t1, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirT1.PubSub},
      # Start a worker by calling: ElixirT1.Worker.start_link(arg)
      # {ElixirT1.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirT1Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirT1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirT1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
