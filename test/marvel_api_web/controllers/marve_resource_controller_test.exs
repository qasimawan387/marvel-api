defmodule MarvelApiWeb.MarvelResourceControllerTest do
  use MarvelApiWeb.ConnCase
  import Mock

  test "get characters from Marvel Api", %{conn: conn} do
    with_mock HTTPoison,
      get: fn _ ->
        {:ok,
         %{
           body:
             "{\"data\":{\"count\":1,\"limit\":1,\"offset\":0,\"results\":[{\"description\":\"\",\"id\":123,\"name\":\"3-D Man\"}],\"total\":50}}"
         }}
      end do
      response =
        conn
        |> post("/api/get_characters")
        |> json_response(200)

      assert %{
               "count" => 1,
               "limit" => 1,
               "offset" => 0,
               "results" => [%{"description" => "", "id" => 123, "name" => "3-D Man"}],
               "total" => 50,
               "total_requests_count" => 1
             } == response
    end
  end
end
