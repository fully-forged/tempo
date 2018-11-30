defmodule Mgmt.Library.Album do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "albums" do
    field :release_date, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :release_date])
    |> validate_required([:title, :release_date])
  end
end
