# frozen_string_literal: true

class IngredientConversionRepository < Hanami::Repository
  associations do
    belongs_to :ingredient
  end
end
