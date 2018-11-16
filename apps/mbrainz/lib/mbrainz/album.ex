defmodule Mbrainz.Album do
  defstruct [:id, :title, :artists, :date]

  alias Mbrainz.Artist

  def from_api_result(results) when is_list(results) do
    Enum.map(results, &from_api_result/1)
  end

  def from_api_result(result) do
    %__MODULE__{
      id: Map.get(result, "id"),
      title: Map.get(result, "title"),
      date: extract_date(result),
      artists:
        result
        |> get_in(["artist-credit", Access.all(), "artist"])
        |> Artist.from_api_result()
    }
  end

  defp extract_date(result) do
    case Map.get(result, "date") do
      nil -> :not_available
      date_string -> Date.from_iso8601!(date_string)
    end
  end
end
