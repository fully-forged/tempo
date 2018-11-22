defmodule Mgmt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    if Keyword.get(args, :enable_metrics, false) do
      Mgmt.Repo.Metrics.attach_telemetry_events()
    end

    children = [
      Mgmt.Repo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Mgmt.Supervisor)
  end
end
