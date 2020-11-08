# frozen_string_literal: true

module Web
  module Controllers
    module Authentication
      include Infrastructure::Authentication

      def self.included(action)
        action.class_eval do
          expose :current_user
        end
      end
    end
  end
end
