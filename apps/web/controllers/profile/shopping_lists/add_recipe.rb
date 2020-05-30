# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        class AddRecipe
          include Web::Action
          include Web::Controllers::Profile::Authentication

          params do
            required(:add_to_list).schema do
              optional(:recipe_id).maybe(:int?)
              optional(:shopping_list_id).maybe(:int?)
            end
          end

          def call(params)
            recipe = find_recipe(params[:add_to_list])
            shopping_list = find_shopping_list(params[:add_to_list])

            return unless recipe && shopping_list

            add_ingredients_to_list.call(recipe: recipe, shopping_list: shopping_list)

            redirect_to routes.profile_shopping_list_path(id: shopping_list.id)
          end

          private

          def add_ingredients_to_list
            AddRecipeIngredientsToShoppingList.new
          end

          def find_recipe(params)
            RecipeRepository.new.find_with_ingredients(params.fetch(:recipe_id))
          end

          def find_shopping_list(params)
            ShoppingListRepository.new.find_with_items(
              id: params.fetch(:shopping_list_id),
              user_id: current_user.id
            )
          end
        end
      end
    end
  end
end
