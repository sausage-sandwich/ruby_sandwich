# frozen_string_literal: true

module Web
  module Controllers
    module Profile
      module Recipes
        class Create
          include Web::Action
          include Web::Controllers::Profile::Authentication

          expose :recipe

          params do
            required(:recipe).schema do
              required(:title).filled(:str?)
              required(:body).filled(:str?)
              optional(:image).schema do
                required(:tempfile) { filled? }
                optional(:filename).maybe(:str?)
                optional(:type).maybe(:str?)
                optional(:name).maybe(:str?)
              end
              required(:recipe_ingredients, :array).each do
                schema do
                  required(:title).filled(:str?)
                  optional(:unit).maybe(:str?)
                  optional(:quantity).maybe(:float?)
                end
              end
            end
          end

          def call(params)
            return unless params.valid?

            result = create_recipe.call(params[:recipe].merge(user_id: current_user.id))
            @recipe = result.recipe

            redirect_to routes.profile_recipe_path(id: @recipe.id) if result.success?
          end

          private

          def create_recipe
            CreateRecipe.new
          end
        end
      end
    end
  end
end
