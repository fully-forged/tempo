defmodule Core.Config do
  @moduledoc """
  Minimal, env-based configuration management with support
  for defaults and casting to specific types.
  """

  @doc """
  Reads a configuration value from the environment.

  Supports names as atoms (not module names) or underscored
  strings, which will be converted to uppercased, underscored
  environment variable names.

  E.g. `:pg_host` will become `PG_HOST`

  Supports two options:

  - `cast_to`: supported values are `:int` and `:atom`. If a
    value is found, a cast to that type will be attempted (note
    that for atoms, only existing ones are taken into account)
  - `default`: in case a value is not found, the default one
    is provided (without being casted).
  """
  def get(name, opts \\ []) do
    value = name |> to_env_variable |> System.get_env()

    if value do
      cast(value, Keyword.get(opts, :cast_to, :string))
    else
      Keyword.get(opts, :default, value)
    end
  end

  defp to_env_variable(name) do
    name
    |> to_string
    |> String.upcase()
  end

  defp cast(value, :int), do: String.to_integer(value)
  defp cast(value, :atom), do: String.to_existing_atom(value)
  defp cast(value, :charlist), do: String.to_charlist(value)
  defp cast(value, _type), do: value
end
