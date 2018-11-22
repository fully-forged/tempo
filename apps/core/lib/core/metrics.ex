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
      [:vm, :proc_count],
      [:vm, :proc_limit],
      [:vm, :port_count],
      [:vm, :port_limit],
      [:vm, :atom_count],
      [:vm, :messages_in_queues],
      [:vm, :modules],
      [:vm, :run_queue],
      [:vm, :reductions],
      [:vm, :memory, :total],
      [:vm, :memory, :procs_used],
      [:vm, :memory, :atom_used],
      [:vm, :memory, :binary],
      [:vm, :memory, :ets],
      [:vm, :io, :bytes_in],
      [:vm, :io, :bytes_out],
      [:vm, :io, :count],
      [:vm, :io, :words_reclaimed],
      [:vm, :scheduler_wall_time, :active],
      [:vm, :scheduler_wall_time, :total]
    ]

    Telemetry.attach_many(
      "tempo-vm",
      events,
      __MODULE__,
      :send_metric,
      Engine
    )
  end

  def send_metric([:vm, measurement], value, meta, engine) do
    case meta.type do
      :counter ->
        engine.increment("vm_#{measurement}", value)

      :gauge ->
        engine.gauge("vm_#{measurement}", value)

      :timing ->
        engine.timing("vm_#{measurement}", value)
    end
  end

  def send_metric([:vm, measurement, field], value, meta, engine) do
    opts = metric_opts(meta)

    case meta.type do
      :counter ->
        engine.increment("vm_#{measurement}.#{field}", value, opts)

      :gauge ->
        engine.gauge("vm_#{measurement}.#{field}", value, opts)

      :timing ->
        engine.timing("vm_#{measurement}.#{field}", value, opts)
    end
  end

  def connect do
    Application.put_env(:statix, Engine,
      host: Core.Config.get(:telegraf_host),
      port: Core.Config.get(:telegraf_port, cast_to: :int)
    )

    Engine.connect()
  end

  defp metric_opts(%{scheduler_number: scheduler_number}) do
    [tags: ["scheduler_number:#{scheduler_number}"]]
  end

  defp metric_opts(_meta), do: []
end
