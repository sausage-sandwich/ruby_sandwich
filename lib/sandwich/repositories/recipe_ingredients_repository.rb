# frozen_string_literal: true

class RecipeIngredientsRepository < Hanami::Repository
  associations do
    belongs_to :recipe
    belongs_to :ingredient
  end
end
