defmodule Mbrainz.ApiClient do
  @moduledoc """
  Interact with the Musicbrainz HTTP api.

  All responses are provided in full, with JSON-decoded body.
  """

  @base_url "https://musicbrainz.org/ws/2"
  @coverart_base_url "https://coverartarchive.org"
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

    case HTTPClient.json_get(@base_url <> path, @headers, params) do
      %HTTPClient.Response{status_code: status_code, duration: elapsed_us} = response ->
        Telemetry.execute([:mbrainz, :api, :ok], elapsed_us, %{
          action: :search_album,
          status_code: status_code
        })

        response

      %HTTPClient.ErrorResponse{duration: elapsed_us} = error_response ->
        Telemetry.execute([:mbrainz, :api, :error], elapsed_us, %{action: :search_album})
        error_response
    end
  end

  @doc """
  Given a Mbrainz album id, return relevant artworks.
  """
  def get_artworks(album_id) do
    path = "/release/#{album_id}"

    case HTTPClient.json_get(@coverart_base_url <> path, @headers) do
      %HTTPClient.Response{status_code: status_code, duration: elapsed_us} = response ->
        Telemetry.execute([:mbrainz, :api, :ok], elapsed_us, %{
          action: :get_artworks,
          status_code: status_code
        })

        response

      %HTTPClient.ErrorResponse{duration: elapsed_us} = error_response ->
        Telemetry.execute([:mbrainz, :api, :error], elapsed_us, %{action: :get_artworks})
        error_response
    end
  end
end
