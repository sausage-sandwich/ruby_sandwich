# frozen_string_literal: true

class RecipeRepository < Hanami::Repository
  associations do
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
  end

  def find_with_ingredients(id)
    aggregate(recipe_ingredients: :ingredient).where(id: id).map_to(Recipe).one
  end

  def create_with_recipe_ingredients(attrs)
    assoc(:recipe_ingredients).create(attrs)
  end
end
