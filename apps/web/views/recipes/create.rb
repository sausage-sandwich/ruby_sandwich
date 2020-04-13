# frozen_string_literal: true

module Web
  module Views
    module Recipes
      class Create
        include Web::View
        template 'recipes/show'
      end
    end
  end
end
