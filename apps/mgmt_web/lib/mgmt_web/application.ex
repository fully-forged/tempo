defmodule MgmtWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    if Keyword.get(args, :enable_metrics, false) do
      MgmtWeb.Endpoint.Metrics.attach_telemetry_events()
    end

    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      MgmtWeb.Endpoint
      # Starts a worker by calling: MgmtWeb.Worker.start_link(arg)
      # {MgmtWeb.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MgmtWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MgmtWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
