# frozen_string_literal: true

RSpec.describe NutritionFacts do
  let(:facts) { described_class.new(carbohydrates_mg: 1000, fat_mg: 1000, protein_mg: 1000) }

  describe 'calories' do
    subject(:calories) { facts.calories }

    it 'calculates energy from nutrients' do
      expect(calories).to eq 17
    end
  end

  describe '+' do
    subject(:summary_facts) do
      facts + facts
    end

    it 'sums nutrition facts' do
      expect(summary_facts).to have_attributes(
        carbohydrates_mg: 2000,
        fat_mg: 2000,
        protein_mg: 2000
      )
    end
  end
end
