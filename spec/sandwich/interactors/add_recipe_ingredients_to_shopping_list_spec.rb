# frozen_string_literal: true

RSpec.describe AddRecipeIngredientsToShoppingList do
  subject(:add_ingredients) { instance.call(recipe: recipe, shopping_list: shopping_list) }

  let(:instance) { described_class.new }
  let(:recipe) { Factory::Recipes.call }
  let(:recipe_ingredient) { recipe.recipe_ingredients.first }
  let(:shopping_list) { Factory::ShoppingList.call }
  let(:reloaded_shopping_list) do
    ShoppingListRepository.new.find_with_items(id: shopping_list.id)
  end

  it 'adds all recipes ingredients to shopping list' do
    add_ingredients

    expect(reloaded_shopping_list.shopping_list_items.count).to eq 1
    expect(reloaded_shopping_list.shopping_list_items.first).to have_attributes(
      title: recipe_ingredient.ingredient.title,
      unit: recipe_ingredient.unit,
      quantity: recipe_ingredient.quantity
    )
  end
end
