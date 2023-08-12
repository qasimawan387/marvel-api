defmodule MarvelApiWeb.MarvelResourceView do
  use MarvelApiWeb, :view

  def render("characters.json", %{records: records}) do
    render_many(records, __MODULE__, "character.json", as: :character)
  end

  def render("character.json", %{character: data}) do
    %{
      id: data["id"],
      name: data["name"],
      description: data["description"]
    }
  end
end
