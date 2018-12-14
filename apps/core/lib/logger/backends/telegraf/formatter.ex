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
    allowed_metadata = extract_metadata(md, metadata)

    pre =
      :io_lib.format('<~B>~B ~s ~s ~s ~p - ', [
        facility ||| level_num,
        version,
        Utils.iso8601_timestamp(ts),
        hostname,
        appid,
        self()
      ])

    [
      pre,
      format_metadata(allowed_metadata),
      Logger.Formatter.format(format, level, msg, ts, [])
    ]
  end

  defp extract_metadata(md, :all), do: md
  defp extract_metadata(md, metadata), do: Keyword.take(md, metadata)

  # Lifted from Logger.Formatter

  defp format_metadata([]), do: ""

  defp format_metadata(meta) do
    pairs =
      Enum.map(meta, fn {key, val} ->
        [?\s, to_string(key), ?=, ?", metadata(key, val), ?"]
      end)

    ["[meta", pairs, ?], ?\s]
  end

  defp metadata(:initial_call, {mod, fun, arity})
       when is_atom(mod) and is_atom(fun) and is_integer(arity) do
    Exception.format_mfa(mod, fun, arity)
  end

  defp metadata(_, pid) when is_pid(pid) do
    :erlang.pid_to_list(pid)
  end

  defp metadata(_, ref) when is_reference(ref) do
    '#Ref' ++ rest = :erlang.ref_to_list(ref)
    rest
  end

  defp metadata(_, atom) when is_atom(atom) do
    case Atom.to_string(atom) do
      "Elixir." <> rest -> rest
      "nil" -> ""
      binary -> binary
    end
  end

  defp metadata(_, other), do: to_string(other)
end
