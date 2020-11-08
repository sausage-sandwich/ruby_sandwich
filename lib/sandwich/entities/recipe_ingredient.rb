# frozen_string_literal: true

class RecipeIngredient < Hanami::Entity
  def nutrition_facts_per_quantity
    nutrition_facts * (quantity_in_grams / 100)
  end

  def nutrition_facts
    build_nutrition_facts || ingredient.nutrition_facts
  end

  def quantity_in_grams
    Unit.new(quantity, unit, conversion_rates).convert_to_grams.quantity
  end

  def conversions_mg
    (ingredient.conversions || []).each_with_object({}) do |conversion, memo|
      memo[conversion.unit.to_sym] = conversion.weight_mg
    end
  end

  private

  def build_nutrition_facts
    return unless carbohydrates_mg && fat_mg && protein_mg

    NutritionFacts.new(
      carbohydrates_mg: carbohydrates_mg,
      fat_mg: fat_mg,
      protein_mg: protein_mg
    )
  end
end
