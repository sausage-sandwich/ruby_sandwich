# frozen_string_literal: true

require_relative './units'

module Web
  module Views
    module Recipes
      class Update
        include Web::View
        include Web::Views::Recipes::Units
      end
    end
  end
end
