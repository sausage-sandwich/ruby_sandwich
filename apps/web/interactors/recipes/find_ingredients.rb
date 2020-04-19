# frozen_string_literal: true

module Web
  module Interactors
    module Recipes
      class FindIngredients
        include Interactor
        include Interactor::FailCircuit

        delegate :attrs, to: :context
        delegate :recipe_ingredients, to: :context

        def call
          context.recipe_ingredients = attrs.fetch(:recipe_ingredients, []).map do |params|
            ingredient = find_or_create_ingredient(params.fetch(:title))
            params.merge(ingredient_id: ingredient.id)
          end
          attrs.merge!(recipe_ingredients: recipe_ingredients)
        end

        private

        def recipe_repo
          @recipe_repo ||= RecipeRepository.new
        end

        def find_or_create_ingredient(title)
          result = fail_circuit do
            Web::Interactors::RecipeIngredients::FindOrCreate.call(title: title)
          end
          result.ingredient
        end
      end
    end
  end
end
