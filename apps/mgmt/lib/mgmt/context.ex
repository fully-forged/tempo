defmodule Mgmt.Context do
  defstruct mbrainz: Mbrainz,
            repo: Mgmt.Repo

  def new, do: %__MODULE__{}

  def override(initial \\ new(), key, value) do
    Map.put(initial, key, value)
  end
end
