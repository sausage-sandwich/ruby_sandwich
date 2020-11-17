# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipeIngredientsForRecipe
  include Hanami::Interactor

  def call(recipe:, recipe_ingredient_params:)
    existing_recipe_ingredients = recipe_ingredient_params.select { |param| param[:id] }

    delete_old_ingredients(recipe, existing_recipe_ingredients)
    update_existing_ingredient_params(existing_recipe_ingredients)
    create_new_ingredients(recipe, recipe_ingredient_params)
  end

  private

  def update_existing_ingredient_params(recipe_ingredient_params)
    recipe_ingredient_params.each do |params|
      recipe_ingredient_repo.update(params.fetch(:id), params.slice(:unit, :quantity))
    end
  end

  def create_new_ingredients(recipe, recipe_ingredient_params)
    recipe_ingredient_params.reject { |param| param[:id] }.map do |param|
      attrs = param.slice(:quantity, :unit).
        merge(
          ingredient_id: ingredient_id_for(param.fetch(:title)),
          recipe_id: recipe.id
        )
      recipe_ingredient_repo.create(attrs)
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

  def delete_old_ingredients(recipe, existing_recipe_ingredients)
    old_recipe_ingredients = recipe_ingredient_repo.for_recipe(recipe).to_a
    for_deletion = old_recipe_ingredients.map(&:id) - existing_recipe_ingredients.map { |param| param[:id] }

    recipe_ingredient_repo.delete_ids(for_deletion)
  end

  def find_or_create_ingredient
    @find_or_create_ingredient ||= FindOrCreateIngredient.new
  end

  def recipe_ingredient_repo
    @recipe_ingredient_repo ||= RecipeIngredientRepository.new
  end
end
