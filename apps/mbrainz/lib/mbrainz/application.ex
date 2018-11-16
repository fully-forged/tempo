defmodule Mbrainz.Application do
  @moduledoc false

  use Application

  def start(_type, args) do
    if Keyword.get(args, :enable_metrics, false) do
      Mbrainz.Metrics.setup!()
    end

    children = []

    opts = [strategy: :one_for_one, name: Foo.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
