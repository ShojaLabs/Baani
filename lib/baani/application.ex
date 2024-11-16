defmodule Baani.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BaaniWeb.Telemetry,
      Baani.Repo,
      {DNSCluster, query: Application.get_env(:baani, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Baani.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Baani.Finch},
      # Start a worker by calling: Baani.Worker.start_link(arg)
      # {Baani.Worker, arg},
      # Start to serve requests, typically the last entry
      BaaniWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Baani.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BaaniWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
