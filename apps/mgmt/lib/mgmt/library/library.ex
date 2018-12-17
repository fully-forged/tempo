defmodule Mgmt.Library do
  @moduledoc """
  The Library context, used to manage albums.
  """

  import Ecto.Query, warn: false

  alias Mgmt.Library.Album

  def size(ctx \\ Mgmt.Context.new()) do
    ctx.repo.aggregate(Album, :count, :id)
  end

  @doc """
  Searches for an album given the title
  """
  def lookup_album(title, ctx \\ Mgmt.Context.new()) do
    ctx.mbrainz.search_album(title)
  end

  @doc """
  Returns the list of albums.

  ## Examples

      iex> list_albums()
      [%Album{}, ...]

  """
  def list_albums(ctx \\ Mgmt.Context.new()) do
    ctx.repo.all(Album)
  end

  @doc """
  Gets a single album.

  Raises `Ecto.NoResultsError` if the Album does not exist.

  ## Examples

      iex> get_album!(123)
      %Album{}

      iex> get_album!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album!(id, ctx \\ Mgmt.Context.new()), do: ctx.repo.get!(Album, id)

  @doc """
  Creates a album.

  ## Examples

      iex> create_album(%{title: "Use Your Illusion I"})
      {:ok, %Album{}}

      iex> create_album(%{title: 1})
      {:error, %Ecto.Changeset{}}

  """
  def create_album(attrs \\ %{}, ctx \\ Mgmt.Context.new()) do
    %Album{}
    |> Album.changeset(attrs)
    |> ctx.repo.insert()
  end

  @doc """
  Updates a album.

  ## Examples

      iex> update_album(album, %{title: "Use Your Illusion II"})
      {:ok, %Album{}}

      iex> update_album(album, %{title: 1})
      {:error, %Ecto.Changeset{}}

  """
  def update_album(%Album{} = album, attrs, ctx \\ Mgmt.Context.new()) do
    album
    |> Album.changeset(attrs)
    |> ctx.repo.update()
  end

  @doc """
  Deletes a Album.

  ## Examples

      iex> delete_album(album)
      {:ok, %Album{}}

      iex> delete_album(album)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album(%Album{} = album, ctx \\ Mgmt.Context.new()) do
    ctx.repo.delete(album)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album changes.

  ## Examples

      iex> change_album(album)
      %Ecto.Changeset{source: %Album{}}

  """
  def change_album(%Album{} = album) do
    Album.changeset(album, %{})
  end
end
