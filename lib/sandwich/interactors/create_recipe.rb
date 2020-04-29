# frozen_string_literal: true

require 'hanami/interactor'

class CreateRecipe
  include Hanami::Interactor

  expose :recipe

  def call(recipe_params)
    ingredients_params = build_ingredient_params(recipe_params.fetch(:recipe_ingredients, []))

    @recipe = recipe_repo.create_with_recipe_ingredients(
      recipe_params.
        slice(:title, :body, :user_id).
        merge(recipe_ingredients: ingredients_params)
    )
  end

  private

  def build_ingredient_params(recipe_ingredient_params)
    recipe_ingredient_params.map do |recipe_ingredient_param|
      result = find_or_create_ingredient.call(title: recipe_ingredient_param.fetch(:title))

      if result.success?
        recipe_ingredient_param.
          slice(:quantity, :unit).
          merge(ingredient_id: result.ingredient.id)
      else
        error!('could not create all ingredients')
      end
    end
  end

  def find_or_create_ingredient
    @find_or_create_ingredient ||= FindOrCreateIngredient.new
  end

  def recipe_repo
    @recipe_repo ||= RecipeRepository.new
  end
end
