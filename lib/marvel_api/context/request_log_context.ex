defmodule MarvelApi.Context.RequestLogContext do
  import Ecto.Query
  alias MarvelApi.Repo
  alias MarvelApi.RequestLog

  @doc """
  This function is used to create the request logs
  """
  @spec create(map()) :: {:ok, RequestLog.t()} | {:error, Ecto.Changeset.t()}
  def create(params) do
    %RequestLog{}
    |> RequestLog.changeset(params)
    |> Repo.insert()
  end

  @doc """
  This function is used to get the request logs count against the request_endpoint
  """
  @spec get_request_logs_count_by_endpoint(String.t()) :: integer()
  def get_request_logs_count_by_endpoint(endpoint) do
    RequestLog
    |> where([r], r.request_endpoint == ^endpoint)
    |> select([r], count(r))
    |> Repo.one()
  end
end
