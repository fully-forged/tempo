defmodule Mbrainz.Artwork do
  defstruct [:id, :types, :large_url, :small_url]

  def from_api_result(results) when is_list(results) do
    Enum.map(results, &from_api_result/1)
  end

  def from_api_result(result) do
    %__MODULE__{
      id: Map.get(result, "id"),
      types:
        result
        |> Map.get("types")
        |> Enum.map(&String.downcase/1),
      large_url: get_in(result, ["thumbnails", "large"]),
      small_url: get_in(result, ["thumbnails", "small"])
    }
  end
end
