defmodule Mbrainz.Context do
  defstruct api_client: Mbrainz.ApiClient

  def new, do: %__MODULE__{}

  def override(initial \\ new(), key, value) do
    Map.put(initial, key, value)
  end
end
