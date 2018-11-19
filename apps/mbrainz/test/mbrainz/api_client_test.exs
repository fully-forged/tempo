defmodule Mbrainz.ApiClientTest do
  use ExUnit.Case, async: true

  alias Mbrainz.ApiClient

  describe "search_album/2" do
    @tag :network
    test "supports exact match" do
      assert %HTTPClient.Response{body: body} =
               ApiClient.search_album("Under the fragmented sky", exact_match: true)

      assert %{
               "count" => 4,
               "releases" => [
                 %{"title" => "Under The Fragmented Sky", "score" => 100} | _other_releases
               ]
             } = body
    end

    @tag :network
    test "defaults to a loose match" do
      assert %HTTPClient.Response{body: body} = ApiClient.search_album("Under the fragmented sky")

      assert %{
               "count" => albums_count,
               "releases" => [
                 %{"title" => "Under The Fragmented Sky", "score" => 100} | other_albums
               ]
             } = body

      assert albums_count > 1
      assert Enum.count(other_albums) > 0
    end
  end

  describe "get_artwork/1" do
    @tag :network
    test "fetches artwork information" do
      assert %HTTPClient.Response{body: body} =
               ApiClient.get_artworks("76df3287-6cda-33eb-8e9a-044b5e15ffdd")

      assert %{"images" => images} = body
      assert Enum.count(images) == 3
    end
  end
end
