# frozen_string_literal: true

RSpec.describe IngredientRepository, type: :repository do
  describe 'alphabetical' do
    subject(:ingredient_titles) { repo.alphabetical.to_a.map(&:title) }

    let(:repo) { described_class.new }

    before do
      repo.create(title: 'carrot')
      repo.create(title: 'asparagus')
      repo.create(title: 'broccoli')
    end

    it 'returns ingredients in alphabetical order' do
      expect(ingredient_titles).to eq %w[asparagus broccoli carrot]
    end
  end
end
