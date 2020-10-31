# frozen_string_literal: true

RSpec.describe Web::Views::Recipes::Show, type: :view do
  let(:exposures) { { recipe: recipe, current_user: nil, format: :html } }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/recipes/show.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:recipe) { recipe_repo.all_with_ingredients.first }
  let(:ingredient) do
    ingredient_repo = IngredientRepository.new
    ingredient_repo.create(title: 'carrot', carbohydrates_mg: 3000, fat_mg: 1000, protein_mg: 2000)
  end
  let(:recipe_repo) { RecipeRepository.new }

  before do
    user = UserRepository.new.create(id: 1, email: 'email1@mail.com', password: '123')

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
      let(:user) { User.new(id: 1) }

      it 'allows edition' do
        can_edit = view.can_edit_recipe?(recipe, user)

        expect(can_edit).to eq true
      end
    end

    context 'when user is not the recipe author' do
      let(:user) { User.new(id: 100500) }

      it 'disallows edition' do
        can_edit = view.can_edit_recipe?(recipe, user)

        expect(can_edit).to eq false
      end
    end
  end
end
