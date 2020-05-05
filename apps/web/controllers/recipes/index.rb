# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action

        expose :recipes

        def call(params)
          repo = RecipeRepository.new

          @recipes = repo.latest
        end
      end
    end
  end
end
