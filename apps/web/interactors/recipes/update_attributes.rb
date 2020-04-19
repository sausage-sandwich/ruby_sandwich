# frozen_string_literal: true

module Web
  module Interactors
    module Recipes
      class UpdateAttributes
        include Interactor

        delegate :recipe, :attrs, to: :context

        def call
          recipe_repo.update(recipe.id, attrs)
        end

        private

        def recipe_repo
          @recipe_repo ||= RecipeRepository.new
        end
      end
    end
  end
end
