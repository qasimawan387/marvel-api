defmodule MarvelApi.Context.MarvelResourceContext do
  alias MarvelApi.Utils.CacheUtils
  alias MarvelApi.Utils.HttpClientUtils

  @doc """
  This function is used to get the resource from Marvel Api accroding to give resource
  """
  @spec get_resource_from_marvel_api(String.t(), map()) ::
          {:ok, list()} | {:error, HTTPoison.Error.t()}
  def get_resource_from_marvel_api(resource, params) do
    case CacheUtils.get_records_from_cache() do
      {:ok, nil} ->
        do_get_resource_from_marvel_api(resource, params)

      {:ok, data} ->
        if check_limit_offset(params, data) do
          {:ok, data}
        else
          do_get_resource_from_marvel_api(resource, params)
        end
    end
  end

  defp do_get_resource_from_marvel_api(resource, params) do
    resource
    |> HttpClientUtils.process_url(params)
    |> HTTPoison.get()
    |> case do
      {:ok, response} ->
        response.body
        |> Jason.decode()
        |> CacheUtils.put_records_in_cache()

      error ->
        error
    end
  end

  defp check_limit_offset(%{"limit" => limit, "offset" => offset}, data) do
    if data["limit"] == limit && data["offset"] == offset do
      true
    end
  end

  defp check_limit_offset(_, data), do: {:ok, data}
end
