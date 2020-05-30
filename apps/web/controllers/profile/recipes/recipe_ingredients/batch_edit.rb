# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        module RecipeIngredients
          class BatchEdit
            include Web::Action
            include Web::Controllers::Profile::Authentication

            expose :recipe

            def call(params)
              @recipe = recipe_repo.find_with_ingredients_for_user(
                params[:recipe_id],
                current_user.id
              )
            end

            private

            def recipe_repo
              RecipeRepository.new
            end
          end
        end
      end
    end
  end
end
