# frozen_string_literal: true

RSpec.describe Recipe, type: :entity do
  describe 'nutrition_facts' do
    subject(:summary_facts) { recipe.nutrition_facts }

    let(:recipe) do
      described_class.new(
        ingredients: [
          Ingredient.new(title: 'Carrot', carbohydrates_mg: 1000, fat_mg: 1000, protein_mg: 1000),
          Ingredient.new(title: 'Potato', carbohydrates_mg: 1000, fat_mg: 1000, protein_mg: 1000)
        ]
      )
    end

    it 'calculates summary facts of the ingredients' do
      expect(summary_facts).to have_attributes(
        carbohydrates_mg: 2000,
        fat_mg: 2000,
        protein_mg: 2000,
        calories: 34
      )
    end
  end
end
