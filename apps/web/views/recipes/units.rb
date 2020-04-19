# frozen_string_literal: true

module Web
  module Views
    module Recipes
      module Units
        def units
          Unit::UNITS.each_with_object({}) do |unit, memo|
            memo[unit] = unit
          end
        end
      end
    end
  end
end
