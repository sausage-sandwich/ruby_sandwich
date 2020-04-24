# frozen_string_literal: true

module Web
  module Controllers
    module Users
      class Create
        include Web::Action

        params do
          required(:user).schema do
            required(:email).filled(:str?)
            required(:password).filled(:str?)
            optional(:name).maybe(:str?)
          end
        end

        def call(params)
          if params.valid?
            user_repo = UserRepository.new
            user_repo.create(params)
          end
        end
      end
    end
  end
end
