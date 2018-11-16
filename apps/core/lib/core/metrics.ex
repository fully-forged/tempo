defmodule Core.Metrics do
  defmodule Engine do
    use Statix, runtime_config: true
  end

  def connect do
    Application.put_env(:statix, Engine,
      host: System.get_env("TELEGRAF_HOST"),
      port: System.get_env("TELEGRAF_PORT") |> String.to_integer()
    )

    Engine.connect()
  end
end
