# frozen_string_literal: true

RSpec.describe Web::Forms::Profile::Recipes::RecipeIngredients::BatchUpdate do
  subject(:attrs) { described_class.new(params).attributes }

  let(:params) { [recipe_ingredient] }
  let(:recipe_ingredient) do
    { id: 1, unit_g: 5, protein_g: 5.5, fat_g: 1, carbohydrates_g: 2 }
  end

  it 'returns correct attributes' do
    expect(attrs).to eq(
      [
        { id: 1, unit_mg: 5000, protein_mg: 5500, fat_mg: 1000, carbohydrates_mg: 2000 }
      ]
    )
  end

  context 'when unit weight is not given' do
    let(:recipe_ingredient) do
      { id: 1, protein_g: 5.5, fat_g: 1, carbohydrates_g: 2 }
    end

    it 'returns correct attributes' do
      expect(attrs).to eq(
        [
          { id: 1, unit_mg: nil, protein_mg: 5500, fat_mg: 1000, carbohydrates_mg: 2000 }
        ]
      )
    end
  end
end
