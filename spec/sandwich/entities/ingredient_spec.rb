# frozen_string_literal: true

RSpec.describe Ingredient, type: :entity do
  describe 'nutrition_facts' do
    subject(:nutrition_facts) { ingredient.nutrition_facts }

    let(:ingredient) do
      described_class.new(carbohydrates_mg: 2000, fat_mg: 2000, protein_mg: 2000)
    end

    it 'calculates calories from macronutrients' do
      expect(nutrition_facts).to have_attributes(
        carbohydrates_mg: 2000,
        fat_mg: 2000,
        protein_mg: 2000,
        calories: 34
      )
    end
  end
end
