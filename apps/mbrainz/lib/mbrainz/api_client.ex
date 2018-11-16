defmodule Mbrainz.ApiClient do
  @moduledoc """
  Interact with the Musicbrainz HTTP api.

  All responses are provided in full, with JSON-decoded body.
  """

  @base_url "https://musicbrainz.org/ws/2"
  @user_agent "Tempo music library management"
  @headers %{"User-Agent" => @user_agent}

  @doc """
  Searches for an album (as a release in Mbrainz terms).

  Can pass an `exact_match` optional flag (defaults to `false`) to
  restrict results.
  """
  def search_album(album_name, opts \\ []) do
    path = "/release"

    query =
      if Keyword.get(opts, :exact_match, false) do
        # double quotes enforce literal match
        ~s(release:"#{album_name}")
      else
        "release:" <> album_name
      end

    params = %{query: query, fmt: "json"}

    HTTPClient.json_get(@base_url <> path, @headers, params)
  end
end
