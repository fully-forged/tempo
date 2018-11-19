defmodule Mbrainz.ArtworkTest do
  use ExUnit.Case, async: true

  alias Mbrainz.Artwork

  @artworks_result [
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
  ]

  describe "from_api_result/1" do
    @tag :unit
    test "extracts artwork data" do
      [artwork | _other_artworks] = Artwork.from_api_result(@artworks_result)

      assert artwork.id == "829521842"
      assert artwork.types == ["front"]

      assert artwork.large_url ==
               "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-500.jpg"

      assert artwork.small_url ==
               "http://coverartarchive.org/release/76df3287-6cda-33eb-8e9a-044b5e15ffdd/829521842-250.jpg"
    end
  end
end
