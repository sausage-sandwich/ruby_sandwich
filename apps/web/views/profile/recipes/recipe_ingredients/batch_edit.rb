# frozen_string_literal: true

require_relative '../units'
require_relative '../../../shared/display_unit'
require_relative '../../../shared/ingredients'

module Web
  module Views
    module Profile
      module Recipes
        module RecipeIngredients
          class BatchEdit
            include Web::View
            include Web::Views::Shared::DisplayUnit
            include Web::Views::Shared::Ingredients
            include Web::Views::Profile::Recipes::Units
          end
        end
      end
    end
  end
end
