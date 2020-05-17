# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class Show
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe, :shopping_lists

          def call(params)
            @recipe = recipe_repo.find_with_ingredients(params[:id])

            shopping_lists = shopping_lists_repo.by_user(user_id: current_user.id)
            @shopping_lists = shopping_lists.to_a.each_with_object({}) do |list, memo|
              memo[list.title] = list.id
            end
          end

          private

          def recipe_repo
            RecipeRepository.new
          end

          def shopping_lists_repo
            ShoppingListRepository.new
          end
        end
      end
    end
  end
end
