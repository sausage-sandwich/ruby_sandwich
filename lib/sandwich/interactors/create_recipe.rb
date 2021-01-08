# frozen_string_literal: true

require 'hanami/interactor'

class CreateRecipe
  include Hanami::Interactor

  expose :recipe

  def call(recipe_params)
    image_data = build_image_params(recipe_params.fetch(:image, {}))

    recipe = recipe_repo.create(recipe_params.slice(:title, :body, :user_id).merge(image_data))
    UpdateRecipeIngredientsForRecipe.new.call(
      recipe: recipe,
      recipe_ingredient_params: recipe_params.fetch(:recipe_ingredients, [])
    )
    @recipe = recipe_repo.find_with_ingredients(recipe.id)
  end

  private

  def build_image_params(image_params)
    file = (image_params || {}).fetch(:tempfile, nil)
    return {} unless file

    data = build_image_data.call(file).image_data

    { image_data: data.to_json }
  end

  def build_image_data
    BuildImageData.new
  end

  def recipe_repo
    @recipe_repo ||= RecipeRepository.new
  end

  def ingredient_repo
    @ingredient_repo ||= IngredientRepository.new
  end
end
