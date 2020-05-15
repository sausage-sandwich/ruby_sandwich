# frozen_string_literal: true

RSpec.describe UpdateRecipe do
  subject(:recipe) { result.recipe }

  let(:result) { described_class.new.call(existing_recipe, params) }
  let(:params) do
    {
      title: 'title2',
      body: 'body2',
      recipe_ingredients: [recipe_ingredient_params]
    }
  end
  let(:recipe_ingredient_params) do
    {
      title: 'potato',
      quantity: 2,
      unit: 'kg'
    }
  end
  let(:recipe_repo) { RecipeRepository.new }
  let(:existing_recipe) do
    recipe_repo.create_with_recipe_ingredients(
      title: 'title1',
      body: 'body1',
      recipe_ingredients: [
        {
          ingredient_id: ingredient.id,
          quantity: 1,
          unit: 'kg'
        }
      ]
    )
  end
  let(:ingredient) do
    ingredient_repo = IngredientRepository.new
    ingredient_repo.create(title: 'carrot')
  end

  it 'updates recipe' do
    expect(recipe).to have_attributes(
      title: 'title2',
      body: 'body2'
    )
    expect(recipe.recipe_ingredients.first).to have_attributes(
      quantity: 2,
      unit: 'kg'
    )
    expect(recipe.recipe_ingredients.first.ingredient).to have_attributes(title: 'potato')
  end
end
