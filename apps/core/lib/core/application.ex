defmodule Core.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    configure_logger!()

    if Keyword.get(args, :enable_metrics, false) do
      Core.Metrics.start_vm_stats()
      Core.Metrics.connect()
      Core.Metrics.attach_telemetry_events()
    end

    children = []

    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def configure_logger! do
    Logger.configure_backend(Logger.Backends.Telegraf,
      facility: :local1,
      appid: "tempo",
      format: "$message",
      metadata: :all,
      host: Core.Config.get(:telegraf_host, cast_to: :charlist),
      port: Core.Config.get(:telegraf_syslog_port, cast_to: :int)
    )
  end
end
