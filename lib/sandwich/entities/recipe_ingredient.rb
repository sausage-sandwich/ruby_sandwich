# frozen_string_literal: true

class RecipeIngredient < Hanami::Entity
  def nutrition_facts_per_quantity
    ingredient.nutrition_facts * (quantity_in_grams / 100)
  end

  def quantity_in_grams
    Unit.new(quantity, unit).convert_to_grams.quantity
  end
end
