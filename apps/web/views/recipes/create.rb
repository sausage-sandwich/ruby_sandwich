# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class Create
        include Web::View
        template 'recipes/new'

        # FIXME remove duplication in Views::Recipes::New
        def units
          { kg: :kg, g: :g }
        end
      end
    end
  end
end
