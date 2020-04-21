# frozen_string_literal: true

module Admin
  module Controllers
    module Ingredients
      class Index
        include Admin::Action

        expose :ingredients

        def call(_params)
          repo = IngredientRepository.new

          @ingredients = repo.alphabetical
        end
      end
    end
  end
end
