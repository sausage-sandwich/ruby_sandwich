# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        module RecipeIngredients
          class BatchUpdate
            include Web::Action
            include Web::Controllers::Profile::Authentication

            params do
              required(:recipe_id).filled(:int?)
              required(:recipe).schema do
                required(:recipe_ingredients, :array).each do
                  schema do
                    required(:id).filled(:str?)
                    optional(:unit).maybe(:str?)
                    optional(:quantity).maybe(:float?)
                    optional(:fat_g).maybe(:float?)
                    optional(:carbohydrates_g).maybe(:float?)
                    optional(:protein_g).maybe(:float?)
                    optional(:unit_g).maybe(:float?)
                  end
                end
              end
            end

            def call(params)
              recipe = find_recipe(params)
              update_recipe_ingredients.call(recipe_ingredient_params(params)) if params.valid?

              redirect_to routes.profile_recipe_path(id: recipe.id)
            end

            private

            def recipe_ingredient_params(params)
              Web::Forms::Profile::Recipes::RecipeIngredients::BatchUpdate.new(
                params[:recipe].fetch(:recipe_ingredients, [])
              ).attributes
            end

            def find_recipe(params)
              recipe_repo.find_with_ingredients_for_user(
                params[:recipe_id],
                current_user.id
              )
            end

            def recipe_repo
              RecipeRepository.new
            end

            def update_recipe_ingredients
              UpdateRecipeIngredients.new
            end
          end
        end
      end
    end
  end
end
