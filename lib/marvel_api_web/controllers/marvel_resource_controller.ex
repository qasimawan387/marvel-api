defmodule MarvelApiWeb.MarvelResourceController do
  use MarvelApiWeb, :controller
  alias MarvelApi.Context.MarvelResourceContext
  alias MarvelApi.Context.RequestLogContext
  @characters_resource "characters"

  @doc """
  This function is used to get characters from Marvel Api
  params = %{"limit" => limit, "offset" => offset}
  """
  @spec get_characters(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def get_characters(conn, params) do
    with {:ok, records} <-
           MarvelResourceContext.get_resource_from_marvel_api(@characters_resource, params),
         {:ok, %{"request_endpoint" => endpoint} = params} <- set_params(conn),
         {:ok, _request_log} <- RequestLogContext.create(params) do
      total_requests_count = RequestLogContext.get_request_logs_count_by_endpoint(endpoint)

      render(conn, "characters.json", %{data: records, total_requests_count: total_requests_count})
    end
  end

  defp set_params(conn) do
    params = %{
      "request_timestamp" => DateTime.utc_now(),
      "request_endpoint" => conn.request_path,
      "response_status_code" => 200
    }

    {:ok, params}
  end
end
