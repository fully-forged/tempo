defmodule Core.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    if Keyword.get(args, :enable_metrics, false) do
      Core.Metrics.connect()
    end

    children = []

    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end