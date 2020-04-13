# frozen_string_literal: true

class RecipeIngredientRepository < Hanami::Repository
  associations do
    belongs_to :recipe
    belongs_to :ingredient
  end
end
