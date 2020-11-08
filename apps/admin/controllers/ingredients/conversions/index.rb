# frozen_string_literal: true

module Admin
  module Controllers
    module Ingredients
      module Conversions
        class Index
          include Admin::Action

          expose :ingredient_conversions

          def call(_params)
            @ingredient_conversions = repo.for_ingredient(params[:ingredient_id])
          end

          private

          def repo
            IngredientConversionRepository.new
          end
        end
      end
    end
  end
end
