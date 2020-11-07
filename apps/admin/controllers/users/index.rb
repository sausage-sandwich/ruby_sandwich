# frozen_string_literal: true

module Admin
  module Controllers
    module Users
      class Index
        include Admin::Action

        params do
          optional(:page).maybe(:int?)
        end

        expose :users

        def call(params)
          repo = UserRepository.new

          @users = repo.by_created_at(page: params[:page] || 1)
        end
      end
    end
  end
end
