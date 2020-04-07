# frozen_string_literal: true

class RecipeRepository < Hanami::Repository
  associations do
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
  end

  def find_with_ingredients(id)
    aggregate(:ingredients).where(id: id).map_to(Recipe).one
  end
end
