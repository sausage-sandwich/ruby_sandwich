# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class New
        include Web::View

        def units
          Units::UNITS.each_with_object({}) do |unit, memo|
            memo[unit] = unit
          end
        end
      end
    end
  end
end
