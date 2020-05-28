# frozen_string_literal: true

require 'hanami/interactor'

class AddRecipeIngredientsToShoppingList
  include Hanami::Interactor

  def call(recipe:, shopping_list:)
    recipe.recipe_ingredients.each do |recipe_ingredient|
      item = find_or_create_item(shopping_list, recipe_ingredient)
      update_quantity(item, recipe_ingredient)
    end
  end

  private

  def update_quantity(item, recipe_ingredient)
    shopping_list_item_repo.update(
      item.id,
      unit: recipe_ingredient.unit,
      quantity: item.quantity.to_f + recipe_ingredient.quantity.to_f
    )
  end

  def find_or_create_item(shopping_list, recipe_ingredient)
    find_item_in_list(shopping_list, recipe_ingredient) ||
      create_item_in_list(shopping_list, recipe_ingredient)
  end

  def find_item_in_list(shopping_list, recipe_ingredient)
    title = normalized_title(recipe_ingredient.ingredient.title)

    shopping_list_item_repo.find_by_list_and_title(shopping_list.id, title)
  end

  def create_item_in_list(shopping_list, recipe_ingredient)
    shopping_list_item_repo.create(
      ingredient_id: recipe_ingredient.ingredient.id,
      title: normalized_title(recipe_ingredient.ingredient.title),
      shopping_list_id: shopping_list.id
    )
  end

  def normalized_title(title)
    title.strip.downcase
  end

  def shopping_list_item_repo
    ShoppingListItemRepository.new
  end
end
