defmodule Mbrainz do
  @moduledoc """
  Top level functions to interact with the Musicbrainz service
  """

  alias Mbrainz.{Album, Context}

  @doc """
  Search for an album.

  Search options:

  - `exact_match` (bool): restricts search results to case-insensitive
    exact matches.

  Can optionally pass a `Mbrainz.Context` as last argument.
  """
  def search_album(album_name, opts \\ [exact_match: false], ctx \\ Context.new()) do
    case ctx.api_client.search_album(album_name, opts) do
      %HTTPClient.Response{status_code: 200, body: body} ->
        albums =
          body
          |> Map.get("releases")
          |> Album.from_api_result()

        {:ok, albums}

      error_response ->
        {:error, :api_client_error, error_response}
    end
  end
end
