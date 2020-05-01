# frozen_string_literal: true

RSpec.describe Web::Controllers::Profile::Recipes::Create, type: :action do
  it_behaves_like 'anonymous user in profile controllers'

  let(:action) { described_class.new }
  let(:params) { {} }

  context 'when user signed in' do
    include_context 'signed in user'

    let(:params) do
      {
        recipe: {
          title: 'title',
          body: 'body',
          recipe_ingredients: [
            {
              title: 'orange',
              quantity: 1,
              unit: 'piece'
            }
          ]
        }
      }
    end

    it 'is successful' do
      expect(subject[0]).to eq 302
    end
  end
end
