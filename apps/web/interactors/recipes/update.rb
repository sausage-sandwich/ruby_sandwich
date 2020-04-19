# frozen_string_literal: true

require_relative './update_attributes'

module Web
  module Interactors
    module Recipes
      class Update
        include Interactor::Organizer

        delegate :recipe, :attrs, to: :context

        organize Web::Interactors::Recipes::FindIngredients,
          Web::Interactors::Recipes::ReplaceRecipeIngredients,
          Web::Interactors::Recipes::UpdateAttributes
      end
    end
  end
end
