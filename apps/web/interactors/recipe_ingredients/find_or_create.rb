# frozen_string_literal: true

# frozen_string_literal: true

module Web
  module Interactors
    module RecipeIngredients
      class FindOrCreate
        include Interactor

        delegate :title, to: :context

        def call
          context.ingredient = ingredient_repo.find_by_title(title) || ingredient_repo.create(title: title)
        end

        private

        def ingredient_repo
          @ingredient_repo ||= IngredientRepository.new
        end
      end
    end
  end
end
