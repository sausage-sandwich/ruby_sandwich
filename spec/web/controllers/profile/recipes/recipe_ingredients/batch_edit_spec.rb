# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::Recipes::RecipeIngredients::BatchEdit, type: :action do
  it_behaves_like 'anonymous user in profile controllers'

  let(:action) { described_class.new }
  let(:params) { {} }

  context 'when user signed in' do
    include_context 'signed in user'

    let(:params) { { recipe_id: recipe.id } }
    let(:recipe) { Factory::Recipes.call }

    it 'is successful' do
      expect(subject[0]).to eq 200
    end
  end
end
