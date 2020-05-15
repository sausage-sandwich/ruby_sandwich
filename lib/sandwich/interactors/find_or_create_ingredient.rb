# frozen_string_literal: true

require 'hanami/interactor'

class FindOrCreateIngredient
  include Hanami::Interactor

  expose :ingredient

  def call(title:)
    @ingredient = ingredient_repo.find_by_title(title) || ingredient_repo.create(title: title)
  end

  private

  def ingredient_repo
    @ingredient_repo ||= IngredientRepository.new
  end
end
