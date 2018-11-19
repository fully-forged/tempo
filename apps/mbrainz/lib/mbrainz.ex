defmodule Mbrainz do
  @moduledoc """
  Top level functions to interact with the Musicbrainz service
  """

  alias Mbrainz.{Album, Artwork, Context}

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

  @doc """
  Get artworks for a given album id.

  Can optionally pass a `Mbrainz.Context` as last argument.
  """
  def get_artworks(album_id, ctx \\ Context.new()) do
    case ctx.api_client.get_artworks(album_id) do
      %HTTPClient.Response{status_code: 200, body: body} ->
        artworks =
          body
          |> Map.get("images")
          |> Artwork.from_api_result()

        {:ok, artworks}

      error_response ->
        {:error, :api_client_error, error_response}
    end
  end
end
