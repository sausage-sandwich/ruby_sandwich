# frozen_string_literal: true

class Ingredient < Hanami::Entity
  def nutrition_facts
    NutritionFacts.new(
      carbohydrates_mg: carbohydrates_mg,
      fat_mg: fat_mg,
      protein_mg: protein_mg
    )
  end
end
