# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        class Show
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :shopping_list

          def call(params)
            shopping_list_repo = ShoppingListRepository.new

            @shopping_list = shopping_list_repo.find_with_items(params[:id])
          end
        end
      end
    end
  end
end
