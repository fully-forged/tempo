defmodule Mgmt.Repo.Metrics do
  alias Core.Metrics.Engine

  def attach_telemetry_events do
    events = [
      [:mgmt, :repo, :query]
    ]

    Telemetry.attach_many(
      "tempo-mgmt-repo-metrics",
      events,
      __MODULE__,
      :send_metric,
      Engine
    )
  end

  def send_metric([:mgmt, :repo, :query], duration_nanosec, meta, engine) do
    duration_ms = duration_nanosec / 1_000_000

    case meta.result do
      {:ok, pg_result} ->
        tags = ["command:#{pg_result.command}"]
        engine.timing("postgresql_client.success", duration_ms, tags: tags)

      {:error, pg_error_result} ->
        pg_code = Map.get(pg_error_result.postgres, "pg_code")
        tags = ["error_code:#{pg_code}"]
        engine.timing("postgresql_client.error", duration_ms, tags: tags)
    end
  end
end
