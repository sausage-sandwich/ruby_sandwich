# frozen_string_literal: true

module Web
  module Views
    module Shared
      module Ingredients
        def ingredient_title(recipe_ingredient)
          recipe_ingredient.title || recipe_ingredient.ingredient.title
        end
      end
    end
  end
end
