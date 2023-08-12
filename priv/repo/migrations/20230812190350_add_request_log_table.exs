defmodule MarvelApi.Repo.Migrations.AddRequestLogTable do
  use Ecto.Migration

  def change do
    create table(:request_log) do
      add :request_timestamp, :utc_datetime, null: false
      add :request_endpoint, :string, null: false
      add :response_status_code, :integer, null: false
      timestamps()
    end

    create index(:request_log, [:request_timestamp])
  end
end
