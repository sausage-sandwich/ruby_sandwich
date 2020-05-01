# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      class Show
        include Web::Action
        include Web::Controllers::Profile::Authentication

        expose :recipes

        def call(params)
          repo = RecipeRepository.new

          @recipes = repo.by_user(current_user.id)
        end
      end
    end
  end
end
