# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipe
  include Hanami::Interactor

  expose :recipe

  def call(recipe, recipe_params)
    update_recipe_ingredients(recipe, recipe_params.fetch(:recipe_ingredients, []))

    image_params = build_image_params(recipe_params[:image])

    recipe_repo.update(
      recipe.id,
      recipe_params.slice(:title, :body).
      merge(image_params)
    )

    @recipe = recipe_repo.find_with_ingredients(recipe.id)
  end

  private

  def update_recipe_ingredients(recipe, recipe_ingredient_params)
    old_recipe_ingredients = recipe_ingredient_repo.for_recipe(recipe).to_a
    existing_recipe_ingredients = recipe_ingredient_params.select { |param| param[:id] }
    for_deletion = old_recipe_ingredients.map(&:id) - existing_recipe_ingredients.map { |param| param[:id] }

    existing_recipe_ingredients.each do |attrs|
      recipe_ingredient_repo.update(attrs.fetch(:id), attrs.slice(:unit, :quantity))
    end
    create_recipe_ingredients(recipe, build_ingredient_params(recipe_ingredient_params))
    recipe_ingredient_repo.delete_ids(for_deletion)
  end

  def build_ingredient_params(recipe_ingredient_params)
    recipe_ingredient_params.reject { |param| param[:id] }.map do |param|
      param.slice(:quantity, :unit).merge(ingredient_id: ingredient_id_for(param.fetch(:title)))
    end
  end

  def ingredient_id_for(title)
    result = find_or_create_ingredient.call(title: title)

    if result.success?
      result.ingredient.id
    else
      error!('could not create all ingredients')
    end
  end

  def create_recipe_ingredients(recipe, recipe_ingredients)
    recipe_ingredients.map do |recipe_ingredient|
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
