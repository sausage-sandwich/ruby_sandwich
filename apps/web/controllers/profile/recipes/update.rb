# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class Update
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe

          params do
            required(:recipe).schema do
              required(:title).filled(:str?)
              required(:body).filled(:str?)
              required(:recipe_ingredients, :array).each do
                schema do
                  required(:title).filled(:str?)
                  optional(:unit).maybe(:str?)
                  optional(:quantity).maybe(:float?)
                end
              end
            end
          end

          def call(params)
            @recipe = recipe_repo.find_with_ingredients(params[:id])

            if params.valid?
              result = update_recipe.call(recipe, params[:recipe].merge(user_id: current_user.id))
              @recipe = result.recipe

              redirect_to routes.profile_recipe_path(id: @recipe.id) if result.success?
            end
          end

          private

          def recipe_repo
            RecipeRepository.new
          end

          def update_recipe
            UpdateRecipe.new
          end
        end
      end
    end
  end
end
