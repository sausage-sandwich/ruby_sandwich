# frozen_string_literal: true

RSpec.describe RecipeIngredientRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:recipe) { Factory::Recipes.call }

  describe '#update_ingredient_group_for_recipe' do
    subject(:update_ingredient_group_for_recipe) do
      repo.update_ingredient_group_for_recipe(recipe.id, ingredient_group.id)
    end

    let(:ingredient_group) { ingredient_group_repo.create(recipe_id: recipe.id) }
    let(:recipe_ingredients) { -> { recipe_ingredient_repo.for_recipe(recipe).to_a } }

    it do
      expect { update_ingredient_group_for_recipe }.
        to change { recipe_ingredients.call.map(&:ingredient_group_id) }.
        from([nil]).to([ingredient_group.id])
    end
  end
end
