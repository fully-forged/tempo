defmodule Mbrainz.Log do
  require Logger

  def attach_telemetry_events do
    events = [
      [:mbrainz, :api, :ok],
      [:mbrainz, :api, :error]
    ]

    Telemetry.attach_many(
      "tempo-mbrainz-log",
      events,
      __MODULE__,
      :log,
      nil
    )
  end

  def log([:mbrainz, :api, :ok], duration, meta, nil) do
    status_code = Map.fetch!(meta, :status_code)
    action = Map.get(meta, :action, :unknown)
    params = Map.get(meta, :params, :unknown)

    Logger.info(fn ->
      ~s(evt=mbrainz-api-success status_code=#{status_code} action=#{action} params=#{params} duration=#{
        duration
      })
    end)
  end

  def log([:mbrainz, :api, :error], duration, meta, nil) do
    action = Map.get(meta, :action, :unknown)
    params = Map.get(meta, :params, :unknown)

    Logger.error(fn ->
      ~s(evt=mbrainz-api-error action=#{action} params=#{params} duration=#{duration})
    end)
  end
end
