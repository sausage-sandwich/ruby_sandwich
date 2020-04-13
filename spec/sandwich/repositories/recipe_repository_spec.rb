# frozen_string_literal: true

RSpec.describe RecipeRepository do
  let(:instance) { described_class.new }

  describe '#create_with_recipe_ingredients' do
    subject(:recipe) { instance.create_with_recipe_ingredients(attrs) }

    let(:ingredient) do
      repo = IngredientRepository.new
      repo.create(title: 'carrot')
    end
    let(:attrs) do
      {
        title: 'qwerty',
        body: 'qwerty',
        recipe_ingredients: [
          { ingredient_id: ingredient.id, unit: 'g', quantity: 123.0 }
        ]
      }
    end

    it 'creates recipe with ingredients' do
      expect(recipe).to have_attributes(
        title: attrs[:title],
        body: attrs[:body]
      )
    end
  end
end
