# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        class Create
          include Web::Action
          include Web::Controllers::Profile::Authentication

          params do
            required(:shopping_list).schema do
              required(:title).filled(:str?)
            end
          end

          def call(params)
            if params.valid?
              shopping_list_repo = ShoppingListRepository.new
              shopping_list_repo.create(
                title: params[:shopping_list].fetch(:title),
                user_id: current_user.id
              )
            end

            redirect_to routes.profile_shopping_lists_path
          end
        end
      end
    end
  end
end
