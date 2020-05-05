# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Index
        include Web::Action

        expose :recipes

        def call(params)
          repo = RecipeRepository.new

          @recipes = repo.page(params[:page] || 1)
        end
      end
    end
  end
end
