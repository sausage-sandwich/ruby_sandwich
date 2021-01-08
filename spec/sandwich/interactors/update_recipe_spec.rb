# frozen_string_literal: true

RSpec.describe UpdateRecipe do
  subject(:recipe) { result.recipe }

  let(:result) { described_class.new.call(existing_recipe, params) }
  let(:params) do
    {
      title: 'title2',
      body: 'body2',
      recipe_ingredients: recipe_ingredient_params
    }
  end
  let(:recipe_ingredient_params) { [recipe_ingredient_param] }
  let(:recipe_ingredient_param) { { title: 'potato', quantity: 2, unit: 'kg' } }
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
    expect(recipe.recipe_ingredients.first).to have_attributes(title: 'potato')
  end

  context 'when recipe ingredients contain unchanged ones' do
    let(:recipe_ingredient_params) { [recipe_ingredient_param, unchanged_recipe_ingredient_param] }
    let(:unchanged_recipe_ingredient) { existing_recipe.recipe_ingredients.first }
    let(:unchanged_recipe_ingredient_param) do
      {
        id: unchanged_recipe_ingredient.id,
        title: ingredient.title,
        quantity: 12,
        unit: 'g'
      }
    end
    let(:new_recipe_ingredient_attrs) do
      recipe.recipe_ingredients.map do |ri|
        { title: ri.title, quantity: ri.quantity, unit: ri.unit, ingredient_id: ri.ingredient_id }
      end
    end

    it 'updates existing ingredients and adds new ones' do
      expect(recipe.recipe_ingredients.count).to eq 2
      expect(new_recipe_ingredient_attrs).to contain_exactly(
        { title: nil, quantity: BigDecimal(12), unit: 'g', ingredient_id: ingredient.id },
        { title: 'potato', quantity: BigDecimal(2), unit: 'kg', ingredient_id: nil }
      )
    end
  end
end
