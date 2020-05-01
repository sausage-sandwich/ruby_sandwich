# frozen_string_literal: true

class RecipeRepository < Hanami::Repository
  associations do
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
  end

  def by_user(user_id)
    recipes.where(user_id: user_id).order(Sequel.desc(:created_at))
  end

  def find_with_ingredients(id)
    aggregate(:ingredients, recipe_ingredients: :ingredient).where(id: id).map_to(Recipe).one
  end

  def all_with_ingredients
    aggregate(recipe_ingredients: :ingredient).map_to(Recipe)
  end

  def create_with_recipe_ingredients(attrs)
    assoc(:recipe_ingredients).create(attrs)
  end
end
