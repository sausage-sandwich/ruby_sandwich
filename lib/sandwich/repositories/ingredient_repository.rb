# frozen_string_literal: true

class IngredientRepository < Hanami::Repository
  associations do
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients
  end
end
