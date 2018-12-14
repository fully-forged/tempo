defmodule Logger.Backends.TelegrafTest do
  use ExUnit.Case, async: true

  alias Logger.Backends.Telegraf.Formatter

  test "formats a log line without metadata" do
    [captured_self] = :io_lib.format("~p", [self()])

    example_packet =
      "<142>1 2018-12-13T09:31:06.149Z localhost tempo #{captured_self} - some copy"

    state = %{
      appid: "tempo",
      facility: 136,
      version: 1,
      format: [:message],
      hostname: "localhost",
      level: nil,
      metadata: []
    }

    level = :info
    msg = "some copy"
    ts = {{2018, 12, 13}, {9, 31, 6, 149}}
    md = []

    assert example_packet ==
             Formatter.format(level, msg, ts, md, state) |> :erlang.iolist_to_binary()
  end

  test "formats a log line with metadata" do
    [captured_self] = :io_lib.format("~p", [self()])

    example_packet =
      ~s(<142>1 2018-12-13T09:31:06.149Z localhost tempo #{captured_self} - [meta role="primary"] some copy)

    state = %{
      appid: "tempo",
      facility: 136,
      version: 1,
      format: [:message],
      hostname: "localhost",
      level: nil,
      metadata: :all
    }

    level = :info
    msg = "some copy"
    ts = {{2018, 12, 13}, {9, 31, 6, 149}}
    md = [role: :primary]

    assert example_packet ==
             Formatter.format(level, msg, ts, md, state) |> :erlang.iolist_to_binary()
  end
end
