# frozen_string_literal: true

class IngredientGroupRepository < Hanami::Repository
  associations do
    belongs_to :recipe
    has_many :recipe_ingredients
  end

  def by_recipe(recipe_id)
    ingredient_groups.where(recipe_id: recipe_id).order(Sequel.asc(:created_at))
  end
end
