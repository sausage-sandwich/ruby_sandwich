# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Show
        include Web::Action

        expose :recipe

        params do
          optional(:scale).maybe(:float?)
        end

        def call(params)
          repo = RecipeRepository.new

          recipe = repo.find_with_ingredients(params[:id])
          @recipe = ScaledRecipe.new(recipe, params[:scale] || 1)
        end
      end
    end
  end
end
