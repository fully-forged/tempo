defmodule Mbrainz.Metrics do
  def setup! do
    :ok = connect_statix!()
    attach_telemetry_events!()
  end

  def send_metric([:mbrainz, :api, :ok], duration, meta, _config) do
    action = Map.get(meta, :action, :unknown)
    Mbrainz.Metrics.Statix.timing("mbrainz_api.success", duration, tags: ["action:#{action}"])
  end

  def send_metric([:mbrainz, :api, :error], duration, meta, _config) do
    action = Map.get(meta, :action, :unknown)
    Mbrainz.Metrics.Statix.timing("mbrainz_api.error", duration, tags: ["action:#{action}"])
  end

  defp connect_statix!() do
    Application.put_env(:statix, Mbrainz.Metrics.Statix,
      host: System.get_env("TELEGRAF_HOST"),
      port: System.get_env("TELEGRAF_PORT") |> String.to_integer()
    )

    :ok = Mbrainz.Metrics.Statix.connect()
  end

  defp attach_telemetry_events! do
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
end
