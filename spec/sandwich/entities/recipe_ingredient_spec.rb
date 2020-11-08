# frozen_string_literal: true

RSpec.describe RecipeIngredient, type: :entity do
  describe '#nutrition_facts_per_quantity' do
    subject(:nutrition_facts_per_quantity) { recipe_ingredient.nutrition_facts_per_quantity }

    let(:recipe_ingredient) do
      RecipeIngredient.new(ingredient: carrot, quantity: 200, unit: 'g')
    end
    let(:carrot) do
      Ingredient.new(title: 'Carrot', carbohydrates_mg: 6_900, fat_mg: 1_000, protein_mg: 1_300)
    end

    it 'calculates nutrition facts per quantity' do
      expect(nutrition_facts_per_quantity).to have_attributes(
        carbohydrates_mg: 13_800,
        fat_mg: 2_000,
        protein_mg: 2_600
      )
    end
  end

  describe '#conversion_mg' do
    subject(:conversion_mg) { recipe_ingredient.conversion_mg }

    let(:recipe_ingredient) do
      RecipeIngredient.new(ingredient: carrot, quantity: 200, unit: 'g')
    end
    let(:carrot) do
      Ingredient.new(
        title: 'Carrot',
        carbohydrates_mg: 6_900,
        fat_mg: 1_000,
        protein_mg: 1_300,
        conversions: [conversion]
      )
    end
    let(:conversion) do
      IngredientConversion.new(weight_mg: 10_000, unit: :handful)
    end

    it do
      expect(conversion_mg).to eq(handful: 10_000)
    end
  end
end
