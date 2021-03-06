# frozen_string_literal: true

RSpec.describe FindOrCreateIngredient do
  subject(:ingredient) { described_class.new.call(title: title).ingredient }

  let(:title) { 'carrot' }

  context 'when ingredient exists' do
    let(:ingredient_repo) { IngredientRepository.new }
    let!(:existing_ingredient) { ingredient_repo.create(title: title) }

    it { expect(ingredient).to eq existing_ingredient }

    context 'when ingredient contains trialing spaces' do
      let(:title) { "\t carrot \n" }
      let!(:existing_ingredient) { ingredient_repo.create(title: 'carrot') }

      it { expect(ingredient).to eq existing_ingredient }
    end

    context 'when ingredient contains letters in different cases' do
      let(:title) { 'cArRot' }
      let!(:existing_ingredient) { ingredient_repo.create(title: 'carrot') }

      it { expect(ingredient).to eq existing_ingredient }
    end
  end

  context 'when new ingredient' do
    let(:ingredient_repo) { IngredientRepository.new }

    it 'creates it' do
      expect { ingredient }.to change { ingredient_repo.all.count }.from(0).to(1)
    end
  end
end
