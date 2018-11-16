defmodule Mbrainz.AlbumTest do
  use ExUnit.Case, async: true

  alias Mbrainz.{Album, Artist}

  @albums_result [
    %{
      "artist-credit" => [
        %{
          "artist" => %{
            "disambiguation" => "project of Mariusz Duda",
            "id" => "dd5fcd94-3119-461e-9abc-04c0a8455a12",
            "name" => "Lunatic Soul",
            "sort-name" => "Lunatic Soul"
          }
        }
      ],
      "barcode" => "5902643881129",
      "count" => 1,
      "country" => "PL",
      "date" => "2018-05-25",
      "id" => "ad866aeb-a115-4cb5-beb4-f619b8da0454",
      "label-info" => [
        %{
          "catalog-number" => "MYSTCD332",
          "label" => %{
            "id" => "877b9aa7-2944-4144-93c3-ab74ac400875",
            "name" => "Mystic Production"
          }
        }
      ],
      "media" => [%{"disc-count" => 0, "format" => "CD", "track-count" => 8}],
      "packaging" => "Digipak",
      "release-events" => [
        %{
          "area" => %{
            "id" => "dd7f80c8-f017-3d01-8608-2a8c9c32b954",
            "iso-3166-1-codes" => ["PL"],
            "name" => "Poland",
            "sort-name" => "Poland"
          },
          "date" => "2018-05-25"
        }
      ],
      "release-group" => %{
        "id" => "66312ec4-9fc1-4a9d-b72d-e78add44d01a",
        "primary-type" => "Album",
        "title" => "Under the Fragmented Sky",
        "type-id" => "f529b476-6e62-324f-b0aa-1f3e33d313fc"
      },
      "score" => 100,
      "status" => "Official",
      "text-representation" => %{"language" => "eng", "script" => "Latn"},
      "title" => "Under The Fragmented Sky",
      "track-count" => 8
    },
    %{
      "artist-credit" => [
        %{
          "artist" => %{
            "disambiguation" => "project of Mariusz Duda",
            "id" => "dd5fcd94-3119-461e-9abc-04c0a8455a12",
            "name" => "Lunatic Soul",
            "sort-name" => "Lunatic Soul"
          }
        }
      ],
      "asin" => "B07BF25DWM",
      "barcode" => "802644861227",
      "count" => 1,
      "country" => "XE",
      "date" => "2018-05-25",
      "id" => "6c6ab653-16cb-416f-948a-383b860ddd45",
      "label-info" => [
        %{
          "catalog-number" => "KSCOPE612",
          "label" => %{
            "id" => "5c70b79a-96c6-4732-854c-f3ca837ddb04",
            "name" => "Kscope"
          }
        }
      ],
      "media" => [%{"disc-count" => 1, "format" => "CD", "track-count" => 8}],
      "packaging" => "Digipak",
      "release-events" => [
        %{
          "area" => %{
            "id" => "89a675c2-3e37-3518-b83c-418bad59a85a",
            "iso-3166-1-codes" => ["XE"],
            "name" => "Europe",
            "sort-name" => "Europe"
          },
          "date" => "2018-05-25"
        }
      ],
      "release-group" => %{
        "id" => "66312ec4-9fc1-4a9d-b72d-e78add44d01a",
        "primary-type" => "Album",
        "title" => "Under the Fragmented Sky",
        "type-id" => "f529b476-6e62-324f-b0aa-1f3e33d313fc"
      },
      "score" => 100,
      "status" => "Official",
      "text-representation" => %{"language" => "eng", "script" => "Latn"},
      "title" => "Under the Fragmented Sky",
      "track-count" => 8
    },
    %{
      "artist-credit" => [
        %{
          "artist" => %{
            "disambiguation" => "project of Mariusz Duda",
            "id" => "dd5fcd94-3119-461e-9abc-04c0a8455a12",
            "name" => "Lunatic Soul",
            "sort-name" => "Lunatic Soul"
          }
        }
      ],
      "barcode" => "802644861227",
      "count" => 1,
      "id" => "b61dd593-e4ad-45bb-af0b-9e5759481436",
      "label-info" => [
        %{
          "catalog-number" => "kscope612",
          "label" => %{
            "id" => "1a44b022-4d29-4de0-a3b7-d5841a959ba5",
            "name" => "Kscope"
          }
        }
      ],
      "media" => [%{"disc-count" => 0, "format" => "CD", "track-count" => 8}],
      "packaging" => "Jewel Case",
      "release-group" => %{
        "id" => "66312ec4-9fc1-4a9d-b72d-e78add44d01a",
        "primary-type" => "Album",
        "title" => "Under the Fragmented Sky",
        "type-id" => "f529b476-6e62-324f-b0aa-1f3e33d313fc"
      },
      "score" => 100,
      "status" => "Bootleg",
      "text-representation" => %{"language" => "eng", "script" => "Latn"},
      "title" => "Under the Fragmented Sky",
      "track-count" => 8
    },
    %{
      "artist-credit" => [
        %{
          "artist" => %{
            "disambiguation" => "project of Mariusz Duda",
            "id" => "dd5fcd94-3119-461e-9abc-04c0a8455a12",
            "name" => "Lunatic Soul",
            "sort-name" => "Lunatic Soul"
          }
        }
      ],
      "barcode" => "5902643881136",
      "count" => 1,
      "country" => "PL",
      "date" => "2018-06-15",
      "id" => "015a316d-2ab8-44a5-ba46-3286ff0fe789",
      "label-info" => [
        %{
          "catalog-number" => "MYSTLP057",
          "label" => %{
            "id" => "877b9aa7-2944-4144-93c3-ab74ac400875",
            "name" => "Mystic Production"
          }
        }
      ],
      "media" => [%{"disc-count" => 0, "format" => "CD", "track-count" => 8}],
      "packaging" => "Cardboard/Paper Sleeve",
      "release-events" => [
        %{
          "area" => %{
            "id" => "dd7f80c8-f017-3d01-8608-2a8c9c32b954",
            "iso-3166-1-codes" => ["PL"],
            "name" => "Poland",
            "sort-name" => "Poland"
          },
          "date" => "2018-06-15"
        }
      ],
      "release-group" => %{
        "id" => "66312ec4-9fc1-4a9d-b72d-e78add44d01a",
        "primary-type" => "Album",
        "title" => "Under the Fragmented Sky",
        "type-id" => "f529b476-6e62-324f-b0aa-1f3e33d313fc"
      },
      "score" => 100,
      "status" => "Official",
      "text-representation" => %{"language" => "eng", "script" => "Latn"},
      "title" => "Under The Fragmented Sky",
      "track-count" => 8
    }
  ]

  describe "from_api_result/1" do
    @tag :unit
    test "extracts album data" do
      [album | _other_albums] = Album.from_api_result(@albums_result)

      assert album.id == "ad866aeb-a115-4cb5-beb4-f619b8da0454"
      assert album.title == "Under The Fragmented Sky"
      assert album.date == ~D[2018-05-25]

      assert album.artists ==
               [
                 %Artist{
                   id: "dd5fcd94-3119-461e-9abc-04c0a8455a12",
                   name: "Lunatic Soul"
                 }
               ]
    end

    @tag :unit
    test "fallback when date is not present" do
      assert [~D[2018-05-25], ~D[2018-05-25], :not_available, ~D[2018-06-15]] ==
               @albums_result
               |> Album.from_api_result()
               |> Enum.map(& &1.date)
    end
  end
end
