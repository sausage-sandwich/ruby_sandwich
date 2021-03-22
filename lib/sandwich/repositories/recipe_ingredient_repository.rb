# frozen_string_literal: true

class RecipeIngredientRepository < Hanami::Repository
  associations do
    belongs_to :recipe
    belongs_to :ingredient_group
    belongs_to :ingredient
  end

  def for_recipe(recipe)
    recipe_ingredients.where(recipe_id: recipe.id).map_to(RecipeIngredient)
  end

  def delete_for_recipe(recipe)
    recipe_ingredients.where(recipe_id: recipe.id).delete
  end

  def delete_ids(ids)
    recipe_ingredients.where(id: ids).delete
  end

  def find_with_ingredient(id)
    aggregate(:ingredient).where(id: id).one
  end
end
