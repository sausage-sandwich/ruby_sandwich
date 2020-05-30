# frozen_string_literal: true

require_relative '../units'

module Web
  module Views
    module Profile
      module Recipes
        module RecipeIngredients
          class BatchEdit
            include Web::View
            include Web::Views::Profile::Recipes::Units

            def display_quantity(quantity, unit)
              unit = Unit.new(quantity, unit)
              unit.convert_to_metric.humanize
            end
          end
        end
      end
    end
  end
end
