# frozen_string_literal: true

module Web
  module Controllers
    module Recipes
      class Update
        include Web::Action

        expose :recipe

        def call(params)
          recipe_repo = RecipeRepository.new

          @recipe = recipe_repo.find_with_ingredients(params[:id])
          form = Web::Validators::Recipes::Form.new(params[:recipe]).validate

          if form.success?
            Web::Interactors::Recipes::Update.call!(recipe: @recipe, attrs: form.to_h)

            redirect_to routes.recipe_path(id: @recipe.id)
          end
        end
      end
    end
  end
end
