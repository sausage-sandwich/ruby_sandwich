# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipe
  include Hanami::Interactor

  expose :recipe

  def call(recipe, recipe_params)
    recipe_ingredients = build_ingredient_params(recipe_params)

    recipe_ingredient_repo.delete_for_recipe(recipe)
    create_recipe_ingredients(recipe, recipe_ingredients)
    image_params = build_image_params(recipe_params[:image])

    recipe_repo.update(
      recipe.id,
      recipe_params.slice(:title, :body).
      merge(image_params)
    )

    @recipe = recipe_repo.find_with_ingredients(recipe.id)
  end

  private

  def build_ingredient_params(recipe_params)
    recipe_ingredient_params = recipe_params.fetch(:recipe_ingredients, [])

    recipe_ingredient_params.map do |recipe_ingredient_param|
      result = find_or_create_ingredient.call(title: recipe_ingredient_param.fetch(:title))

      if result.success?
        recipe_ingredient_param.slice(:quantity, :unit).merge(ingredient_id: result.ingredient.id)
      else
        error!('could not create all ingredients')
      end
    end
  end

  def create_recipe_ingredients(recipe, recipe_ingredients)
    recipe_ingredients.each do |recipe_ingredient|
      recipe_ingredient_repo.create(recipe_ingredient.merge(recipe_id: recipe.id))
    end
  end

  def build_image_params(image_params)
    file = (image_params || {}).fetch(:tempfile, nil)
    return {} unless file

    data = build_image_data.call(file).image_data

    { image_data: data.to_json }
  end

  def build_image_data
    BuildImageData.new
  end

  def find_or_create_ingredient
    @find_or_create_ingredient ||= FindOrCreateIngredient.new
  end

  def recipe_ingredient_repo
    @recipe_ingredient_repo ||= RecipeIngredientRepository.new
  end

  def recipe_repo
    @recipe_repo ||= RecipeRepository.new
  end
end
