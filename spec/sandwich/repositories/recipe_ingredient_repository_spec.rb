# frozen_string_literal: true

RSpec.describe RecipeIngredientRepository, type: :repository do
  let(:repo) { described_class.new }
  let(:recipe) { Factory::Recipes.call }

  describe '#update_ingredient_group_for_recipe' do
    subject(:update_ingredient_group_for_recipe) do
      repo.update_ingredient_group_for_recipe(recipe.id, new_ingredient_group.id)
    end

    let(:new_ingredient_group) { Factory::IngredientGroups.call(params: { recipe_id: recipe.id }) }
    let(:recipe_ingredients) { -> { recipe_ingredient_repo.for_recipe(recipe).to_a } }

    it do
      expect { update_ingredient_group_for_recipe }.
        to change { recipe_ingredients.call.map(&:ingredient_group_id) }.
        from(recipe.ingredient_groups.map(&:id)).to([new_ingredient_group.id])
    end
  end
end
