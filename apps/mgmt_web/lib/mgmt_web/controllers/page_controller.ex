defmodule MgmtWeb.PageController do
  use MgmtWeb, :controller

  def index(conn, params) do
    case params do
      %{"title" => title} ->
        case Mgmt.Library.lookup_album(title) do
          {:ok, lookup_results} ->
            render(conn, "lookup_results.html", lookup_results: lookup_results)

          {:error, type, reason} ->
            render(conn, "lookup_error.html", type: type, reason: reason)
        end

      _other ->
        size = Mgmt.Library.size()
        render(conn, "index.html", size: size)
    end
  end
end
