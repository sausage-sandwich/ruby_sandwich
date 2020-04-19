# frozen_string_literal: true

module Web
  module Validators
    module Recipes
      class Form
        include Hanami::Validations::Form

        validations do
          required(:title).filled(:str?)
          required(:body).filled(:str?)
          required(:recipe_ingredients, :array).each do
            schema do
              required(:title).filled(:str?)
              optional(:unit).maybe(:str?)
              optional(:quantity).maybe(:float?)
            end
          end
        end
      end
    end
  end
end
