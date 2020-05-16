# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        module Items
          class Create
            include Web::Action
            include Web::Controllers::Profile::Authentication
            include Web::Controllers::Profile::ShoppingLists::CurrentList

            params do
              required(:shopping_list_id).filled(:int?)
              required(:shopping_list_item).schema do
                required(:title).filled(:str?)
              end
            end

            def call(params)
              if params.valid?
                list_item_repo.create(
                  title: item_title(params),
                  shopping_list_id: current_shopping_list.id
                )
              end

              redirect_to routes.profile_shopping_list_path(id: params[:shopping_list_id])
            end

            private

            def item_title(params)
              params[:shopping_list_item].fetch(:title)
            end

            def list_item_repo
              ShoppingListItemRepository.new
            end
          end
        end
      end
    end
  end
end
