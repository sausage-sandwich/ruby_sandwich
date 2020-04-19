# frozen_string_literal: true

module Web
  module Interactors
    module Recipes
      class ReplaceRecipeIngredients
        include Interactor

        delegate :recipe, :recipe_ingredients, to: :context

        def call
          recipe_ingredient_repo.delete_for_recipe(recipe)
          recipe_ingredients.each do |recipe_ingredient|
            recipe_ingredient_repo.create(recipe_ingredient.merge(recipe_id: recipe.id))
          end
        end

        private

        def recipe_repo
          @recipe_repo ||= RecipeRepository.new
        end

        def recipe_ingredient_repo
          @recipe_ingredient_repo ||= RecipeIngredientRepository.new
        end
      end
    end
  end
end
