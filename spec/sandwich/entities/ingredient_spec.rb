# frozen_string_literal: true

RSpec.describe Ingredient, type: :entity do
  describe 'calories' do
    subject(:calories) { ingredient.calories }

    let(:ingredient) do
      described_class.new(carbohydrates_mg: 2000, fat_mg: 2000, protein_mg: 2000)
    end

    it 'calculates calories from macronutrients' do
      expect(calories).to eq 34
    end
  end
end
