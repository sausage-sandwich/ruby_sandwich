# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class Create
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe

          params do
            required(:recipe).schema do
              required(:title).filled(:str?)
              required(:body).filled(:str?)
              optional(:image).schema do
                required(:tempfile) { filled? }
                optional(:filename).maybe(:str?)
                optional(:type).maybe(:str?)
                optional(:name).maybe(:str?)
              end
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
            if params.valid?
              result = create_recipe.call(params[:recipe].merge(user_id: current_user.id))
              @recipe = result.recipe

              redirect_to routes.profile_recipe_path(id: @recipe.id) if result.success?
            else
              @recipe = build_recipe(params[:recipe])
            end
          end

          private

          def create_recipe
            CreateRecipe.new
          end

          def build_recipe(recipe_params)
            recipe_ingredients = recipe_params[:recipe_ingredients].map do |recipe_ingredient|
              RecipeIngredient.new(
                unit: recipe_ingredient.fetch(:unit),
                quantity: recipe_ingredient.fetch(:quantity),
                ingredient: Ingredient.new(title: recipe_ingredient.fetch(:title))
              )
            end

            result_params = recipe_params.slice(:title, :body, :image).
              merge(recipe_ingredients: recipe_ingredients)

            Recipe.new(result_params)
          end
        end
      end
    end
  end
end
