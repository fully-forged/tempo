defmodule Logger.Backends.Telegraf.Utils do
  use Bitwise

  def iso8601_timestamp({{year, month, date}, {hour, minute, second, micro}}) do
    :io_lib.format(
      "~4..0B-~2..0B-~2..0BT~2..0B:~2..0B:~2..0B.~3..0BZ",
      [year, month, date, hour, minute, second, micro]
    )
    |> to_string
  end

  def facility(:local0), do: 16 <<< 3
  def facility(:local1), do: 17 <<< 3
  def facility(:local2), do: 18 <<< 3
  def facility(:local3), do: 19 <<< 3
  def facility(:local4), do: 20 <<< 3
  def facility(:local5), do: 21 <<< 3
  def facility(:local6), do: 22 <<< 3
  def facility(:local7), do: 23 <<< 3

  def level(:debug), do: 7
  def level(:info), do: 6
  def level(:notice), do: 5
  def level(:warn), do: 4
  def level(:warning), do: 4
  def level(:err), do: 3
  def level(:error), do: 3
  def level(:crit), do: 2
  def level(:alert), do: 1
  def level(:emerg), do: 0
  def level(:panic), do: 0

  def level(i) when is_integer(i) when i >= 0 and i <= 7, do: i
  def level(_bad), do: 3
end
