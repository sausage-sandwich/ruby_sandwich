# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipeIngredients
  include Hanami::Interactor

  expose :recipe_ingredients

  def call(params)
    @recipe_ingredients = params.map do |recipe_ingredient_params|
      id = recipe_ingredient_params.fetch(:id)
      recipe_ingredient_repo.update(id, sanitized_params(recipe_ingredient_params))
      recipe_ingredient_repo.find_with_ingredient(id)
    end
  end

  private

  def sanitized_params(params)
    params.slice(
      :unit,
      :quantity,
      :fat_mg,
      :carbohydrates_mg,
      :protein_mg,
      :unit_mg
    )
  end

  def recipe_ingredient_repo
    RecipeIngredientRepository.new
  end
end
