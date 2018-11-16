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

  defguardp is_present?(a) when not is_nil(a)

  defp extract_date(result) do
    with date_string when is_present?(date_string) <- Map.get(result, "date"),
         {:ok, parsed} <- Date.from_iso8601(date_string) do
      parsed
    else
      _error ->
        :not_available
    end
  end
end
