# frozen_string_literal: true

RSpec.describe Web::Controllers::Recipes::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { recipe: recipe_params } }
  let(:recipe_params) do
    {
      title: 'title',
      body: 'body',
      recipe_ingredients: [
        title: 'carrot',
        unit: 'g',
        quantity: 100.0
      ]
    }
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
