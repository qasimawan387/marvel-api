defmodule MarvelApiWeb.MarvelResourceController do
  use MarvelApiWeb, :controller
  alias MarvelApi.Context.MarvelResourceContext
  @characters_resource "characters"

  @doc """
  This function is used to get characters from Marvel Api
  """
  @spec get_characters(Plug.Conn.t(), any) :: Plug.Conn.t()
  def get_characters(conn, _params) do
    characters = MarvelResourceContext.get_resource_from_marvel_api(@characters_resource)
    render(conn, "characters.json", %{records: characters})
  end
end
