# frozen_string_literal: true

RSpec.describe Web::Views::Recipes::Show, type: :view do
  let(:exposures) { { recipe: recipe, current_user: nil, params: {}, format: :html } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/recipes/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:user) { recipe.user }
  let!(:recipe) { Factory::Recipes.call }
  let(:ingredient) { recipe.recipe_ingredients.first.ingredient }
  let(:recipe_repo) { RecipeRepository.new }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end

  it 'renders view' do
    expect(rendered).to be
  end

  it 'presents nutrient in grams' do
    value = view.nutrient(1000)

    expect(value).to eq '1 g'
  end

  describe 'can_edit_recipe?' do
    context 'when user is the recipe author' do
      it 'allows edition' do
        can_edit = view.can_edit_recipe?(recipe, user)

        expect(can_edit).to eq true
      end
    end

    context 'when user is not the recipe author' do
      let(:user) { Factory::Users.call }

      it 'disallows edition' do
        can_edit = view.can_edit_recipe?(recipe, user)

        expect(can_edit).to eq false
      end
    end
  end
end
