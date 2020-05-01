# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Authentication
        def self.included(action)
          action.class_eval do
            before :authenticate!
          end
        end

        private

        def authenticate!
          redirect_to routes.new_session_path unless current_user
        end
      end
    end
  end
end
