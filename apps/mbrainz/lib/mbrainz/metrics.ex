defmodule Mbrainz.Metrics do
  def setup! do
    :ok = connect_statix!()
  end

  defp connect_statix!() do
    Application.put_env(:statix, Mbrainz.Metrics.Statix,
      host: System.get_env("TELEGRAF_HOST"),
      port: System.get_env("TELEGRAF_PORT") |> String.to_integer()
    )

    :ok = Mbrainz.Metrics.Statix.connect()
  end
end
