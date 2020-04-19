# frozen_string_literal: true

RSpec.describe Web::Interactors::Recipes::Update, type: :action do
  let(:update) { described_class.call(recipe: recipe, attrs: attrs) }
  let(:attrs) do
    {
      title: 'title2',
      body: 'body2',
      recipe_ingredients: [ingredient_params]
    }
  end
  let(:ingredient_params) do
    {
      title: 'ingredient2',
      unit: 'g',
      quantity: 2.0
    }
  end
  let(:ingredient) { IngredientRepository.new.create(title: 'ingredient1') }
  let(:recipe) do
    recipe_repo.create(
      title: 'title1',
      body: 'body1',
      recipe_ingredients: [
        { ingredient_id: ingredient.id, unit: 'g', quantity: 'g' }
      ]
    )
  end
  let(:recipe_repo) { RecipeRepository.new }
  let(:updated_recipe) { recipe_repo.find_with_ingredients(recipe.id) }

  it 'updates recipe' do
    update
    expect(updated_recipe).to have_attributes(
      title: attrs[:title],
      body: attrs[:body]
    )
    expect(updated_recipe.recipe_ingredients.first.ingredient.title).to eq ingredient_params[:title]
  end
end
