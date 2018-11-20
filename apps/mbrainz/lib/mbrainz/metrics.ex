defmodule Mbrainz.Metrics do
  alias Core.Metrics.Engine

  def attach_telemetry_events do
    events = [
      [:mbrainz, :api, :ok],
      [:mbrainz, :api, :error]
    ]

    Telemetry.attach_many(
      "tempo-mbrainz-metrics",
      events,
      __MODULE__,
      :send_metric,
      Engine
    )
  end

  def send_metric([:mbrainz, :api, :ok], duration, meta, engine) do
    action = Map.get(meta, :action, :unknown)
    engine.timing("mbrainz_api.success", duration, tags: ["action:#{action}"])
  end

  def send_metric([:mbrainz, :api, :error], duration, meta, engine) do
    action = Map.get(meta, :action, :unknown)
    engine.timing("mbrainz_api.error", duration, tags: ["action:#{action}"])
  end
end
