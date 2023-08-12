defmodule MarvelApiWeb.FallbackController do
  use MarvelApiWeb, :controller

  def call(conn, {:error, %HTTPoison.Error{reason: :timeout}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MarvelApiWeb.ErrorView)
    |> render("error.json", %{code: 422, message: "request timeout"})
  end

  def call(conn, {:error, changeset = %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MarvelApiWeb.ErrorView)
    |> render("errors.json", %{code: 422, message: "Unprocessable entity", changeset: changeset})
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(MarvelApiWeb.ErrorView)
    |> render("error.json", %{code: 422, message: message})
  end
end
