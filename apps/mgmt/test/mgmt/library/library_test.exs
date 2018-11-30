defmodule Mgmt.LibraryTest do
  use Mgmt.DataCase

  alias Mgmt.Library

  describe "albums" do
    alias Mgmt.Library.Album

    @valid_attrs %{release_date: "some release_date", title: "some title"}
    @update_attrs %{release_date: "some updated release_date", title: "some updated title"}
    @invalid_attrs %{release_date: nil, title: nil}

    def album_fixture(attrs \\ %{}) do
      {:ok, album} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Library.create_album()

      album
    end

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Library.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Library.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      assert {:ok, %Album{} = album} = Library.create_album(@valid_attrs)
      assert album.release_date == "some release_date"
      assert album.title == "some title"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      assert {:ok, %Album{} = album} = Library.update_album(album, @update_attrs)
      assert album.release_date == "some updated release_date"
      assert album.title == "some updated title"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_album(album, @invalid_attrs)
      assert album == Library.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Library.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Library.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Library.change_album(album)
    end
  end
end
