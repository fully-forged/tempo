defmodule Mbrainz.Metrics do
  alias Core.Metrics.Engine

  def attach_telemetry_events do
    events = [
      [:mbrainz, :api, :ok],
      [:mbrainz, :api, :error]
    ]

    Telemetry.attach_many(
      "mbrainz-statix",
      events,
      __MODULE__,
      :send_metric,
      nil
    )
  end

  def send_metric([:mbrainz, :api, :ok], duration, meta, _config) do
    action = Map.get(meta, :action, :unknown)
    Engine.timing("mbrainz_api.success", duration, tags: ["action:#{action}"])
  end

  def send_metric([:mbrainz, :api, :error], duration, meta, _config) do
    action = Map.get(meta, :action, :unknown)
    Engine.timing("mbrainz_api.error", duration, tags: ["action:#{action}"])
  end
end
