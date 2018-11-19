defmodule MbrainzTest do
  use ExUnit.Case

  defmodule ApiClient do
    def search_album("Bohemian Rhapsody", exact_match: true) do
      %HTTPClient.Response{
        status_code: 200,
        body: %{
          "releases" => [
            %{
              "artist-credit" => [
                %{
                  "artist" => %{
                    "disambiguation" => "UK rock group",
                    "id" => "0383dadf-2a4e-4d10-a46a-e9e041da8eb3",
                    "name" => "Queen",
                    "sort-name" => "Queen"
                  }
                }
              ],
              "barcode" => "",
              "count" => 1,
              "country" => "NL",
              "date" => "1975-10-31",
              "id" => "fecc857d-61fd-4ecf-8b3c-d101952c202d",
              "label-info" => [
                %{
                  "catalog-number" => "5C 006-97140",
                  "label" => %{
                    "id" => "c029628b-6633-439e-bcee-ed02e8a338f7",
                    "name" => "EMI"
                  }
                }
              ],
              "media" => [
                %{"disc-count" => 0, "format" => "7\" Vinyl", "track-count" => 2}
              ],
              "packaging" => "Cardboard/Paper Sleeve",
              "release-events" => [
                %{
                  "area" => %{
                    "id" => "ef1b7cc0-cd26-36f4-8ea0-04d9623786c7",
                    "iso-3166-1-codes" => ["NL"],
                    "name" => "Netherlands",
                    "sort-name" => "Netherlands"
                  },
                  "date" => "1975-10-31"
                }
              ],
              "release-group" => %{
                "id" => "361a28b7-4588-44a6-8c96-86c1efb8258f",
                "primary-type" => "Single",
                "title" => "Bohemian Rhapsody",
                "type-id" => "d6038452-8ee0-3f68-affc-2de9a1ede0b9"
              },
              "score" => 50,
              "status" => "Official",
              "text-representation" => %{"language" => "eng"},
              "title" => "Bohemian Rhapsody / I’m in Love With My Car",
              "track-count" => 2
            }
          ]
        }
      }
    end

    def get_artworks("76df3287-6cda-33eb-8e9a-044b5e15ffdd") do
      %HTTPClient.Response{
        body: %{
          "images" => [
            %{
              "approved" => true,
              "back" => false,
              "comment" => "",
              "edit" => 17_462_565,
              "front" => true,
              "id" => "829521842",
              "image" =>
                "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842.jpg",
              "thumbnails" => %{
                "large" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg",
                "small" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-250.jpg"
              },
              "types" => ["Front"]
            },
            %{
              "approved" => true,
              "back" => true,
              "comment" => "",
              "edit" => 24_923_554,
              "front" => false,
              "id" => "5769317885",
              "image" =>
                "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769317885.jpg",
              "thumbnails" => %{
                "large" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769317885-500.jpg",
                "small" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769317885-250.jpg"
              },
              "types" => ["Back"]
            },
            %{
              "approved" => true,
              "back" => false,
              "comment" => "",
              "edit" => 24_923_552,
              "front" => false,
              "id" => "5769316809",
              "image" =>
                "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769316809.jpg",
              "thumbnails" => %{
                "large" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769316809-500.jpg",
                "small" =>
                  "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/5769316809-250.jpg"
              },
              "types" => ["Medium"]
            }
          ],
          "release" => "http://musicbrainz.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd"
        },
        status_code: 200
      }
    end
  end

  describe "get_albums/1,2,3" do
    @tag :unit
    test "it returns relevant albums" do
      ctx = Mbrainz.Context.override(:api_client, ApiClient)

      assert {:ok, [album]} = Mbrainz.search_album("Bohemian Rhapsody", [exact_match: true], ctx)
      assert album.title == "Bohemian Rhapsody / I’m in Love With My Car"
    end
  end

  describe "get_artwork/1,2" do
    @tag :unit
    test "it returns artworks" do
      ctx = Mbrainz.Context.override(:api_client, ApiClient)

      assert {:ok, artworks} = Mbrainz.get_artworks("76df3287-6cda-33eb-8e9a-044b5e15ffdd", ctx)
      assert Enum.count(artworks) == 3
    end
  end
end
