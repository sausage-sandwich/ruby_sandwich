# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Create
        include Web::Action

        expose :recipe

        def call(params)
          recipe_repo = RecipeRepository.new
          ingredient_repo = IngredientRepository.new

          recipe_ingredients = params[:recipe].fetch(:recipe_ingredients, []).map do |recipe_ingredient_params|
            title = recipe_ingredient_params.delete(:title)
            ingredient = ingredient_repo.find_by_title(title) || ingredient_repo.create(title: title)

            recipe_ingredient_params.merge(ingredient_id: ingredient.id)
          end
          recipe = recipe_repo.create(params[:recipe].merge(recipe_ingredients: recipe_ingredients))

          @recipe = recipe_repo.find_with_ingredients(recipe.id)
        end
      end
    end
  end
end
