# frozen_string_literal: true

module Web
  module Controllers
    module Salads
      class New
        include Web::Action

        expose :categories

        def call(_params)
          @categories = GenerateSalad::INGREDIENTS.keys
        end
      end
    end
  end
end
