# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class New
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe

          def call(_params)
            @recipe = Recipe.new(recipe_ingredients: [RecipeIngredient.new])
          end
        end
      end
    end
  end
end
