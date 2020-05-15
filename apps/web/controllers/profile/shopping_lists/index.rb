# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        class Index
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :shopping_lists

          def call(_params)
            shopping_lists_repo = ShoppingListRepository.new

            @shopping_lists = shopping_lists_repo.all
          end
        end
      end
    end
  end
end
