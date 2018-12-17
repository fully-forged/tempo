defmodule MgmtWeb.Endpoint.Metrics do
  alias Core.Metrics.Engine

  def attach_telemetry_events do
    events = [
      [:mgmt_web, :endpoint, :phoenix_controller_call],
      [:mgmt_web, :endpoint, :phoenix_controller_render]
    ]

    Telemetry.attach_many(
      "tempo-mgmt-endpoint-metrics",
      events,
      __MODULE__,
      :send_metric,
      Engine
    )
  end

  def send_metric([:mgmt_web, :endpoint, :phoenix_controller_call], duration_us, meta, engine) do
    duration_ms = duration_us / 1_000
    tags = ["method:#{meta.method}", "controller:#{meta.controller}", "action:#{meta.action}"]

    engine.timing("http_endpoint.call", duration_ms, tags)
  end

  def send_metric([:mgmt_web, :endpoint, :phoenix_controller_render], duration_us, meta, engine) do
    duration_ms = duration_us / 1_000
    tags = ["format:#{meta.format}", "template:#{meta.template}", "view:#{meta.view}"]

    engine.timing("http_endpoint.render", duration_ms, tags)
  end
end
