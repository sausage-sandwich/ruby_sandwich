# frozen_string_literal: true

RSpec.describe UpdateRecipeIngredientsForRecipe do
  subject(:result) do
    described_class.new.call(recipe: recipe, recipe_ingredient_params: recipe_ingredient_params)
  end

  let(:recipe_ingredient_params) do
    [
      existing_recipe_ingredient_params,
      new_recipe_ingredient_params
    ]
  end
  let(:existing_recipe_ingredient_params) do
    {
      id: recipe_ingredient.id,
      unit: 'g',
      quantity: 200
    }
  end
  let(:new_recipe_ingredient_params) do
    {
      title: 'carrot',
      unit: 'g',
      quantity: 100
    }
  end
  let(:recipe_ingredient) do
    recipe_ingredient_repo.create(
      recipe_id: recipe.id,
      unit: 'g',
      quantity: 100,
      ingredient_id: ingredient.id
    )
  end
  let(:recipe) { Factory::Recipes.call }
  let(:ingredient) { Factory::Ingredients.call }
  let(:ingredient_group) { ingredient_group_repo.by_recipe(recipe.id).first }
  let(:recipe_after_update) { recipe_repo.find_with_ingredient_groups(recipe.id) }

  it 'updates existing recipe ingredients' do
    expect(result).to be_success
    expect(recipe_after_update.ingredient_groups).to contain_exactly(ingredient_group)
    expect(recipe_after_update.ingredient_groups.first.recipe_ingredients.count).to eq 2
  end
end
