# frozen_string_literal: true

module Web
  module Controllers
    module Session
      class Create
        include Web::Action

        params do
          required(:session).schema do
            required(:email).filled(:str?)
            required(:password).filled(:str?)
          end
        end

        def call(params)
          if params.valid?
            user_repo = UserRepository.new
            user = user_repo.find_by_email(params[:session].fetch(:email))

            if user && authenticate(user: user, password: params[:session].fetch(:password))
              session[:user_id] = user.id
            end
          end

          redirect_to routes.root_path
        end

        private

        def authenticate(user:, password:)
          BCrypt::Password.new(user.password_digest) == password
        end
      end
    end
  end
end
