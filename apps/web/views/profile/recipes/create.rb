# frozen_string_literal: true

require_relative './units'

module Web
  module Views
    module Profile
      module Recipes
        class Create
          include Web::View
          include Web::Views::Profile::Recipes::Units
        end
      end
    end
  end
end
