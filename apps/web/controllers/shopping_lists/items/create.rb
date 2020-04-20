# frozen_string_literal: true

module Web
  module Controllers
    module ShoppingLists
      module Items
        class Create
          include Web::Action

          params do
            required(:shopping_list_item).schema do
              required(:title).filled(:str?)
            end
          end

          def call(params)
            shopping_list_repo = ShoppingListRepository.new
            shopping_list = shopping_list_repo.find(params[:shopping_list_id])

            if params.valid?
              shopping_list_item_repo = ShoppingListItemRepository.new
              shopping_list_item_repo.create(
                title: params[:shopping_list_item].fetch(:title),
                shopping_list_id: shopping_list.id
              )
            end

            redirect_to routes.shopping_list_path(id: params[:shopping_list_id])
          end
        end
      end
    end
  end
end
