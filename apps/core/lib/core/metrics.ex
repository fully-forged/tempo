defmodule Core.Metrics do
  defmodule Engine do
    use Statix, runtime_config: true
  end

  def start_vm_stats do
    Application.put_env(:vmstats, :sink, Core.Metrics.TelemetryTranslator)
    Application.ensure_all_started(:vmstats)
  end

  def attach_telemetry_events do
    events = [
      [:core, :runtime, :proc_count],
      [:core, :runtime, :proc_limit],
      [:core, :runtime, :port_count],
      [:core, :runtime, :port_limit],
      [:core, :runtime, :atom_count],
      [:core, :runtime, :messages_in_queues],
      [:core, :runtime, :modules],
      [:core, :runtime, :run_queue],
      [:core, :runtime, :reductions],
      [:core, :runtime, :memory, :total],
      [:core, :runtime, :memory, :procs_used],
      [:core, :runtime, :memory, :atom_used],
      [:core, :runtime, :memory, :binary],
      [:core, :runtime, :memory, :ets],
      [:core, :runtime, :io, :bytes_in],
      [:core, :runtime, :io, :bytes_out],
      [:core, :runtime, :io, :count],
      [:core, :runtime, :io, :words_reclaimed],
      [:core, :runtime, :scheduler_wall_time, :active],
      [:core, :runtime, :scheduler_wall_time, :total]
    ]

    Telemetry.attach_many(
      "tempo-core",
      events,
      __MODULE__,
      :send_metric,
      Engine
    )
  end

  def send_metric([:core, :runtime, measurement], value, meta, engine) do
    case meta.type do
      :counter ->
        engine.increment("core_#{measurement}", value)

      :gauge ->
        engine.gauge("core_#{measurement}", value)

      :timing ->
        engine.timing("core_#{measurement}", value)
    end
  end

  def send_metric([:core, :runtime, measurement, field], value, meta, engine) do
    opts = metric_opts(meta)

    case meta.type do
      :counter ->
        engine.increment("core_#{measurement}.#{field}", value, opts)

      :gauge ->
        engine.gauge("core_#{measurement}.#{field}", value, opts)

      :timing ->
        engine.timing("core_#{measurement}.#{field}", value, opts)
    end
  end

  def connect do
    Application.put_env(:statix, Engine,
      host: System.get_env("TELEGRAF_HOST"),
      port: System.get_env("TELEGRAF_PORT") |> String.to_integer()
    )

    Engine.connect()
  end

  defp metric_opts(%{scheduler_number: scheduler_number}) do
    [tags: ["scheduler_number:#{scheduler_number}"]]
  end

  defp metric_opts(_meta), do: []
end
