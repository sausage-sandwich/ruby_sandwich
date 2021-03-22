# frozen_string_literal: true

require 'hanami/interactor'

class UpdateRecipeIngredientsForRecipe
  include Hanami::Interactor

  def call(recipe:, recipe_ingredient_params:)
    existing_recipe_ingredients = recipe_ingredient_params.select { |param| param[:id] }
    ingredient_group = find_or_create_ingredients_group(recipe)
    delete_old_ingredients(recipe, existing_recipe_ingredients)
    update_existing_ingredient_params(ingredient_group, existing_recipe_ingredients)
    create_new_ingredients(ingredient_group, recipe_ingredient_params)
  end

  private

  def update_existing_ingredient_params(ingredient_group, recipe_ingredient_params)
    recipe_ingredient_params.each do |params|
      recipe_ingredient_repo.update(
        params.fetch(:id),
        params.slice(:unit, :quantity).merge(ingredient_group_id: ingredient_group.id)
      )
    end
  end

  def create_new_ingredients(ingredient_group, recipe_ingredient_params)
    recipe_ingredient_params.reject { |param| param[:id] }.map do |param|
      attrs = param.slice(:title, :quantity, :unit).
        merge(
          recipe_id: ingredient_group.recipe_id,
          ingredient_group_id: ingredient_group.id,
          **ingredient_id_for(param.fetch(:title))
        )
      recipe_ingredient_repo.create(attrs)
    end
  end

  def ingredient_id_for(title)
    ingredient = ingredient_repo.find_by_title(title)

    ingredient ? { ingredient_id: ingredient.id } : {}
  end

  def delete_old_ingredients(recipe, existing_recipe_ingredients)
    old_recipe_ingredients = recipe_ingredient_repo.for_recipe(recipe).to_a
    existing_recipe_ingredients_ids = existing_recipe_ingredients.map { |param| param[:id] }
    for_deletion = old_recipe_ingredients.map(&:id) - existing_recipe_ingredients_ids

    recipe_ingredient_repo.delete_ids(for_deletion)
  end

  def find_or_create_ingredients_group(recipe)
    ingredient_group_repo.by_recipe(recipe.id).first ||
      ingredient_group_repo.create(title: recipe.title, recipe_id: recipe.id)
  end

  def ingredient_group_repo
    @ingredient_group_repo ||= IngredientGroupRepository.new
  end

  def ingredient_repo
    @ingredient_repo ||= IngredientRepository.new
  end

  def recipe_ingredient_repo
    @recipe_ingredient_repo ||= RecipeIngredientRepository.new
  end
end
