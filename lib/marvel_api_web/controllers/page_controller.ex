defmodule MarvelApiWeb.PageController do
  use MarvelApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
