# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class Create
        include Web::Action

        expose :user

        params do
          required(:user).schema do
            required(:email).filled(:str?)
            required(:password).filled(:str?)
            optional(:name).maybe(:str?)
          end
        end

        def call(params)
          create_user = CreateUser.new

          return unless params.valid?

          result = create_user.call(params[:user])
          redirect_to routes.root_path if result.success?
        end
      end
    end
  end
end
