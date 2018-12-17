defmodule MgmtWeb.PageView do
  use MgmtWeb, :view

  def join_artist_names(artists) do
    artists
    |> Enum.map(& &1.name)
    |> Enum.join(", ")
  end
end
