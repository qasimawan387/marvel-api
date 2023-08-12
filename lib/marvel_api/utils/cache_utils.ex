defmodule MarvelApi.Utils.CacheUtils do
  @spec put_records_in_cache({:ok, map}) :: {:ok, map}
  def put_records_in_cache({:ok, %{"data" => data}}) do
    Cachex.put(:marvel_api_cache, :marvel_api_data, data)
    {:ok, data}
  end

  @spec get_records_from_cache :: {:ok, nil | map()}
  def get_records_from_cache, do: Cachex.get(:marvel_api_cache, :marvel_api_data)
end
