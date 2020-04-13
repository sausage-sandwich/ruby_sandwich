# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action

        expose :recipes

        def call(_params)
          repo = RecipeRepository.new

          @recipes = repo.all
        end
      end
    end
  end
end
