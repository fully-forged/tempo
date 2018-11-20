defmodule Mbrainz.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    if Keyword.get(args, :enable_metrics, false) do
      Mbrainz.Metrics.attach_telemetry_events()
    end

    Mbrainz.Log.attach_telemetry_events()

    children = []

    opts = [strategy: :one_for_one, name: Mbrainz.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
