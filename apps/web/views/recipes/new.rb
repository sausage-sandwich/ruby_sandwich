# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class New
        include Web::View

        def units
          { kg: :kg, g: :g }
        end
      end
    end
  end
end
