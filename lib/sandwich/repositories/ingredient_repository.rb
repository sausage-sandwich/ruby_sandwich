# frozen_string_literal: true

class IngredientRepository < Hanami::Repository
  associations do
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
    has_many :ingredient_conversions, as: :conversions
  end

  def find_by_title(title)
    ingredients.where(title: title).one
  end

  def alphabetical
    ingredients.order { title.asc }
  end
end
