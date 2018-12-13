defmodule Logger.Backends.Telegraf.Formatter do
  alias Logger.Backends.Telegraf.Utils

  use Bitwise

  def format(level, msg, ts, md, state) do
    %{
      version: version,
      format: format,
      metadata: metadata,
      facility: facility,
      appid: appid,
      hostname: hostname
    } = state

    level_num = Utils.level(level)

    pre =
      :io_lib.format('<~B>~B ~s ~s ~s ~p - - ', [
        facility ||| level_num,
        version,
        Utils.iso8601_timestamp(ts),
        hostname,
        appid,
        self()
      ])

    [pre, Logger.Formatter.format(format, level, msg, ts, Keyword.take(md, metadata))]
  end
end
