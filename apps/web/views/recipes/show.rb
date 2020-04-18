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
      end
    end
  end
end
