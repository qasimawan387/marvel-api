defmodule MarvelApiWeb.MarvelResourceController do
  use MarvelApiWeb, :controller
  alias MarvelApi.Context.MarvelResourceContext
  @characters_resource "characters"

  @doc """
  This function is used to get characters from Marvel Api
  params = %{"limit" => limit, "offset" => offset}
  """
  @spec get_characters(Plug.Conn.t(), any) :: Plug.Conn.t()
  def get_characters(conn, params) do
    with {:ok, records} <-
           MarvelResourceContext.get_resource_from_marvel_api(@characters_resource, params) do
      render(conn, "characters.json", %{data: records})
    end
  end
end
