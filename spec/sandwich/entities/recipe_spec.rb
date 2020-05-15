# frozen_string_literal: true

RSpec.describe Recipe, type: :entity do
  let(:recipe) do
    described_class.new(
      recipe_ingredients: [
        RecipeIngredient.new(ingredient: carrot, quantity: 200, unit: 'g'),
        RecipeIngredient.new(ingredient: potato, quantity: 50, unit: 'g')
      ]
    )
  end
  let(:carrot) do
    Ingredient.new(title: 'Carrot', carbohydrates_mg: 6900, fat_mg: 1000, protein_mg: 1300)
  end
  let(:potato) do
    Ingredient.new(title: 'Potato', carbohydrates_mg: 17_000, fat_mg: 1000, protein_mg: 2000)
  end

  describe '#nutrition_facts_per_quantity' do
    subject(:nutrition_facts_per_quantity) { recipe.nutrition_facts_per_quantity }

    it 'calculates summary facts of the ingredients' do
      expect(nutrition_facts_per_quantity).to have_attributes(
        carbohydrates_mg: BigDecimal(22_300),
        fat_mg: BigDecimal(2500),
        protein_mg: BigDecimal(3600),
        calories: BigDecimal('126.1')
      )
    end
  end

  describe '#nutrition_facts' do
    subject(:nutrition_facts) { recipe.nutrition_facts }

    it 'calculates nutrition facts per 100g' do
      expect(nutrition_facts).to have_attributes(
        carbohydrates_mg: BigDecimal(8_920),
        fat_mg: BigDecimal(1_000),
        protein_mg: BigDecimal(1_440),
        calories: BigDecimal('50.44')
      )
    end
  end
end
