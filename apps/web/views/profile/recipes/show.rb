# frozen_string_literal: true

module Web
  module Views
    module Profile
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
            format('%<value>s g', value: grams)
          end
        end
      end
    end
  end
end
