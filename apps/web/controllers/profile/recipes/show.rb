# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class Show
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe

          def call(params)
            repo = RecipeRepository.new

            @recipe = repo.find_with_ingredients(params[:id])
          end
        end
      end
    end
  end
end
