module Admin
  module Controllers
    module Ingredients
      class Edit
        include Admin::Action

        expose :ingredient

        def call(params)
          repo = IngredientRepository.new

          @ingredient = repo.find(params[:id])
        end
      end
    end
  end
end
