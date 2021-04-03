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
  let(:recipe) { Factory::Recipes.call }
  let(:ingredient) { recipe.ingredients.first }
  let(:user) { recipe.user }

  it 'successfully renderes page' do
    expect { rendered }.not_to raise_error
  end
end
