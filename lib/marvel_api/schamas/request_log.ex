defmodule MarvelApi.RequestLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "request_log" do
    field :request_timestamp, :utc_datetime
    field :request_endpoint, :string
    field :response_status_code, :integer
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :request_timestamp,
      :request_endpoint,
      :response_status_code
    ])
  end
end
