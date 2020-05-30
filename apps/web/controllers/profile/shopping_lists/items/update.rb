# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        module Items
          class Update
            include Web::Action
            include Web::Controllers::Profile::Authentication
            include Web::Controllers::Profile::ShoppingLists::CurrentList

            params do
              required(:shopping_list_id).filled(:int?)
              required(:id).filled(:int?)
              required(:shopping_list_item).schema do
                required(:checked).filled(:bool?)
              end
            end

            def call(params)
              shopping_list_item_repo = ShoppingListItemRepository.new

              item = shopping_list_item_repo.
                find_by_shopping_list(params[:shopping_list_id], params[:id])

              if params.valid? && item
                checked = params[:shopping_list_item].fetch(:checked)
                shopping_list_item_repo.update(item.id, checked: checked)
              end

              redirect_to routes.profile_shopping_list_path(id: params[:shopping_list_id])
            end
          end
        end
      end
    end
  end
end
