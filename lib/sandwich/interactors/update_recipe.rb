# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipe
  include Hanami::Interactor

  expose :recipe

  def call(recipe, recipe_params)
    image_params = build_image_params(recipe_params[:image])
    recipe_repo.update(recipe.id, recipe_params.slice(:title, :body).merge(image_params))

    update_recipe_ingredients_for_recipe.call(
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

  def update_recipe_ingredients_for_recipe
    @update_recipe_ingredients_for_recipe ||= UpdateRecipeIngredientsForRecipe.new
  end

  def recipe_ingredient_repo
    @recipe_ingredient_repo ||= RecipeIngredientRepository.new
  end

  def recipe_repo
    @recipe_repo ||= RecipeRepository.new
  end
end
