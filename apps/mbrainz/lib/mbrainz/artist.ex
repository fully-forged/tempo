defmodule Mbrainz.Artist do
  defstruct [:id, :name]

  def from_api_result(results) when is_list(results) do
    Enum.map(results, &from_api_result/1)
  end

  def from_api_result(result) do
    %__MODULE__{
      id: Map.get(result, "id"),
      name: Map.get(result, "name")
    }
  end
end
