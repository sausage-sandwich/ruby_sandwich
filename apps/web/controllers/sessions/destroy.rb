# frozen_string_literal: true

module Web
  module Controllers
    module Sessions
      class Destroy
        include Web::Action

        def call(_params)
          session[:user_id] = nil

          redirect_to Web.routes.path(:recipes)
        end
      end
    end
  end
end
