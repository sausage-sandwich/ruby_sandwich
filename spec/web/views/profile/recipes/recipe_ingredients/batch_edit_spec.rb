# frozen_string_literal: true

RSpec.describe Web::Views::Profile::Recipes::RecipeIngredients::BatchEdit, type: :view do
  let(:exposures) { { recipe: recipe, current_user: user, params: {}, format: :html } }
  let(:template) do
    Hanami::View::Template.new(
      'apps/web/templates/profile/recipes/recipe_ingredients/batch_edit.html.slim'
    )
  end
  let(:view) { described_class.new(template, exposures) }
  let(:rendered) { view.render }
  let(:recipe) { recipe_repo.all_with_ingredients.first }
  let(:ingredient) do
    ingredient_repo = IngredientRepository.new
    ingredient_repo.create(title: 'carrot', carbohydrates_mg: 3000, fat_mg: 1000, protein_mg: 2000)
  end
  let(:recipe_repo) { RecipeRepository.new }
  let(:user) { UserRepository.new.create(id: 1, email: 'email1@mail.com', password: '123') }

  before do
    recipe_repo.create_with_recipe_ingredients(
      title: 'title',
      body: 'body',
      user_id: user.id,
      recipe_ingredients: [
        {
          ingredient_id: ingredient.id,
          ingredient: ingredient,
          quantity: 100,
          unit: 'g'
        }
      ]
    )
  end

  it 'successfully renderes page' do
    expect { rendered }.not_to raise_error
  end
end
