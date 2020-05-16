# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module ShoppingLists
        module CurrentList
          def self.included(action)
            action.class_eval do
              before :find_list!
            end
          end

          private

          def find_list!
            redirect_to routes.profile_shopping_lists_path unless current_shopping_list
          end

          def current_shopping_list
            @current_shopping_list ||= repo.find_by_id_and_user_id(
              id: params[:shopping_list_id],
              user_id: current_user.id
            )
          end

          def repo
            ShoppingListRepository.new
          end
        end
      end
    end
  end
end
