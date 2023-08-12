defmodule MarvelApi.Context.MarvelResourceContext do
  alias MarvelApi.Utils.MarvelApiUtils

  @doc """
  This function is used to get the resource from Marvel Api accroding to give resource
  """
  @spec get_resource_from_marvel_api(String.t(), map()) ::
          {:ok, list()} | {:error, HTTPoison.Error.t()}
  def get_resource_from_marvel_api(resource, params) do
    resource
    |> MarvelApiUtils.process_url(params)
    |> HTTPoison.get()
    |> case do
      {:ok, response} ->
        {:ok, json_data} = Jason.decode(response.body)

        records = process_comics(json_data)
        {:ok, records}

      error ->
        error
    end
  end

  defp process_comics(%{"data" => data}), do: data
end
