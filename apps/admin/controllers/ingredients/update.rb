# frozen_string_literal: true

module Admin
  module Controllers
    module Ingredients
      class Update
        include Admin::Action

        def call(params)
          repo = IngredientRepository.new
          id = params[:id]

          repo.update(id, params[:ingredient])

          redirect_to routes.edit_ingredient_path(id: id)
        end
      end
    end
  end
end
