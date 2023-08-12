defmodule MarvelApi.Context.MarvelResourceContext do
  alias MarvelApi.Utils.MarvelApiUtils

  @doc """
  This function is used to get the resource from Marvel Api accroding to give resource
  """
  @spec get_resource_from_marvel_api(String.t()) :: list
  def get_resource_from_marvel_api(resource) do
    {:ok, response} =
      resource
      |> MarvelApiUtils.process_url()
      |> HTTPoison.get()

    {:ok, json_data} = Jason.decode(response.body)

    process_comics(json_data)
  end

  defp process_comics(%{"data" => %{"results" => comics}}) do
    Enum.map(comics, fn comic ->
      comic |> Map.take(["comics", "id", "name", "description"])
    end)
  end
end
