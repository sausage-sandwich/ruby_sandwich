# frozen_string_literal: true

require_relative './units'

module Web
  module Views
    module Recipes
      class Create
        include Web::View
        include Web::Views::Recipes::Units

        template 'recipes/new'
      end
    end
  end
end
