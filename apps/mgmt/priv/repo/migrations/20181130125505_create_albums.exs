defmodule Mgmt.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :release_date, :string

      timestamps()
    end
  end
end
