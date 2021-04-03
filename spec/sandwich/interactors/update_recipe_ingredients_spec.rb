# frozen_string_literal: true

RSpec.describe UpdateRecipeIngredients do
  subject(:recipe_ingredients) { result.recipe_ingredients }

  let(:result) { described_class.new.call(params) }
  let(:params) { [recipe_ingredient_params] }
  let(:recipe_ingredient_params) do
    {
      id: recipe_ingredient.id,
      fat_mg: 3000,
      carbohydrates_mg: 2000,
      protein_mg: 5000,
      unit_mg: 4000
    }
  end
  let(:recipe_ingredient_repo) { RecipeIngredientRepository.new }
  let(:recipe_ingredient) do
    recipe_ingredient_repo.create(
      recipe_id: recipe.id,
      unit: 'g',
      quantity: 100,
      ingredient_id: ingredient.id
    )
  end
  let(:recipe) do
    recipe_repo = RecipeRepository.new
    recipe_repo.create(title: 'title', body: 'body')
  end
  let(:ingredient) do
    ingredient_repo = IngredientRepository.new
    ingredient_repo.create(title: 'carrot')
  end

  it 'updates recipe ingredients' do
    expect(recipe_ingredients.first).to have_attributes(
      fat_mg: recipe_ingredient_params.fetch(:fat_mg),
      carbohydrates_mg: recipe_ingredient_params.fetch(:carbohydrates_mg),
      protein_mg: recipe_ingredient_params.fetch(:protein_mg),
      unit_mg: recipe_ingredient_params.fetch(:unit_mg)
    )
  end

  context 'when unit weight is not given' do
    let(:recipe_ingredient_params) do
      {
        id: recipe_ingredient.id,
        fat_mg: 3000,
        carbohydrates_mg: 2000,
        protein_mg: 5000
      }
    end

    it 'updates recipe ingredients' do
      expect(recipe_ingredients.first).to have_attributes(
        fat_mg: recipe_ingredient_params.fetch(:fat_mg),
        carbohydrates_mg: recipe_ingredient_params.fetch(:carbohydrates_mg),
        protein_mg: recipe_ingredient_params.fetch(:protein_mg),
        unit_mg: nil
      )
    end
  end
end
