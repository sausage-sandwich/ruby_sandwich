# frozen_string_literal: true

module Web
  module Controllers
    module ShoppingLists
      class Create
        include Web::Action

        params do
          required(:shopping_list).schema do
            required(:title).filled(:str?)
          end
        end

        def call(params)
          if params.valid?
            shopping_list_repo = ShoppingListRepository.new
            shopping_list_repo.create(title: params[:shopping_list].fetch(:title))
          end

          redirect_to routes.shopping_lists_path
        end
      end
    end
  end
end
