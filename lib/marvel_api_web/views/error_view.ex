defmodule MarvelApiWeb.ErrorView do
  use MarvelApiWeb, :view

  def render("error.json", %{code: code, message: message}) do
    %{error: %{code: code, message: message}}
  end

  def render("errors.json", %{code: code, message: message, changeset: changeset}) do
    %{error: %{code: code, message: message, errors: translate_errors(changeset)}}
  end

  def translate_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
  end
end
