# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Create
        include Web::Action

        expose :recipe

        def call(params)
          recipe_repo = RecipeRepository.new
          ingredient_repo = IngredientRepository.new

          form = Web::Validators::Recipes::Create.new(params[:recipe]).validate
          if form.success?
            attrs = form.to_h
            recipe_ingredients = attrs.fetch(:recipe_ingredients, []).map do |recipe_ingredient_params|
              title = recipe_ingredient_params.delete(:title)
              ingredient = ingredient_repo.find_by_title(title) || ingredient_repo.create(title: title)

              recipe_ingredient_params.merge(ingredient_id: ingredient.id)
            end
            recipe = recipe_repo.create_with_recipe_ingredients(
              attrs.merge(recipe_ingredients: recipe_ingredients)
            )
            redirect_to routes.recipe_path(id: recipe.id)
          else
            @recipe = form
          end
        end
      end
    end
  end
end
