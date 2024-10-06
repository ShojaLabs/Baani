defmodule Shoja.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShojaWeb.Telemetry,
      Shoja.Repo,
      {DNSCluster, query: Application.get_env(:shoja, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Shoja.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Shoja.Finch},
      # Start a worker by calling: Shoja.Worker.start_link(arg)
      # {Shoja.Worker, arg},
      # Start to serve requests, typically the last entry
      ShojaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shoja.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShojaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
