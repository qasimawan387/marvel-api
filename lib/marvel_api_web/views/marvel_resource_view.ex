defmodule MarvelApiWeb.MarvelResourceView do
  use MarvelApiWeb, :view

  def render("characters.json", %{data: data}) do
    %{
      results: render_many(data["results"], __MODULE__, "character.json", as: :character),
      total: data["total"],
      count: data["count"],
      offset: data["offset"],
      limit: data["limit"]
    }
  end

  def render("character.json", %{character: data}) do
    %{
      id: data["id"],
      name: data["name"],
      description: data["description"]
    }
  end
end
