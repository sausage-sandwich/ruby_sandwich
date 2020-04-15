# frozen_string_literal: true

RSpec.describe Web::Controllers::Recipes::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { { recipe: recipe_params } }
  let(:recipe_params) do
    {
      title: 'title',
      body: 'body',
      recipe_ingredients: [
        ingredient_params
      ]
    }
  end
  let(:ingredient_params) do
    {
      title: 'carrot',
      unit: 'g',
      quantity: 100.0
    }
  end
  let(:recipe) { RecipeRepository.new.all_with_ingredients.first }
  let(:ingredient_titles) { recipe.recipe_ingredients.map { |ri| ri.ingredient.title } }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
    expect(recipe).to have_attributes(
      title: recipe_params[:title],
      body: recipe_params[:body]
    )
    expect(ingredient_titles).to contain_exactly(ingredient_params[:title])
  end

  context 'when params are invalid' do
    let(:recipe_params) do
      {
        title: 'title',
        recipe_ingredients: [
          ingredient_params
        ]
      }
    end
    let(:ingredient_params) do
      {
        unit: 'g',
        quantity: 100.0
      }
    end

    it 'shows errors' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end
end
