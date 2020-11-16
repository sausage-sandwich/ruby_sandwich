# frozen_string_literal: true

module Web
  module Views
    module Shared
      module DisplayUnit
        def display_metric_quantity(quantity, unit)
          unit = Unit.new(quantity, unit)
          unit.convert_to_metric.humanize
        end

        def display_imperial_quantity(quantity, unit)
          unit = Unit.new(quantity, unit)
          unit.convert_to_imperial.humanize
        end

        def display_quantity(quantity, unit)
          unit = Unit.new(quantity, unit)
          unit.humanize
        end

        def display_g(value)
          return unless value

          (value / 1000).to_f
        end
      end
    end
  end
end
