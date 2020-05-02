# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class Show
        include Web::View

        def display_quantity(quantity, unit)
          unit = Unit.new(quantity, unit)
          unit.convert_to_metric.humanize
        end

        # NOTE: find build-in function for this
        def text_with_newlines(text)
          safe = h(text)
          raw(safe.split("\n").join('<br/>'))
        end

        def nutrient(milligrams)
          grams = Metric.mg_to_g(milligrams)
          format('%<value>.2f g', value: grams)
        end

        def calories(kkal)
          format('%<value>.0f kkal', value: kkal)
        end

        def nutrition_facts_showable?(recipe)
          return true if recipe.nutrition_facts
        rescue ::Unit::ConversionError
          false
        end
      end
    end
  end
end
