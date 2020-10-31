# frozen_string_literal: true

RSpec.describe ScaledRecipe, type: :entity do
  let(:recipe) do
    Recipe.new(recipe_ingredients: 2.times.map { RecipeIngredient.new(quantity: 1) })
  end
  let(:scaled_recipe) { described_class.new(recipe, 2) }

  it 'equivalents to plain recipe' do
    expect(recipe.to_h).to eq scaled_recipe.to_h
  end

  describe 'recipe ingredients scaling' do
    it 'scales ingredient quantities by given factor' do
      quantities = scaled_recipe.recipe_ingredients.map(&:quantity)

      expect(quantities).to eq [2, 2]
    end
  end
end
