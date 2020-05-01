# frozen_string_literal: true

RSpec.describe CreateRecipe do
  subject(:recipe) { result.recipe }

  let(:result) { described_class.new.call(params) }
  let(:params) do
    {
      title: 'title',
      body: 'body',
      recipe_ingredients: [
        recipe_ingredient_params
      ]
    }
  end
  let(:recipe_ingredient_params) do
    {
      title: 'carrot',
      quantity: 1,
      unit: 'kg'
    }
  end
  let(:recipe_repo) { RecipeRepository.new }

  it 'creates recipe with ingredients' do
    expect { recipe }.to change { recipe_repo.all.count }.by(1)
    expect(recipe).to have_attributes(params.slice(:title, :body))
    expect(recipe.recipe_ingredients.first).to have_attributes(
      quantity: 1,
      unit: 'kg'
    )
  end
end
