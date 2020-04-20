# frozen_string_literal: true

module Web
  module Controllers
    module ShoppingLists
      module Items
        class Update
          include Web::Action

          params do
            required(:shopping_list_item).schema do
              required(:checked).filled(:bool?)
            end
          end

          def call(params)
            shopping_list_item_repo = ShoppingListItemRepository.new

            item = shopping_list_item_repo.
              find_by_shopping_list(params[:shopping_list_id], params[:id])
            puts params.valid?
            if params.valid? && item
              checked = params[:shopping_list_item].fetch(:checked)
              shopping_list_item_repo.update(item.id, checked: checked)
            end

            redirect_to routes.shopping_list_path(id: params[:shopping_list_id])
          end
        end
      end
    end
  end
end
