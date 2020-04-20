# frozen_string_literal: true

class Ingredient < Hanami::Entity
  def calories
    {
      carbohydrates: carbohydrates_mg,
      fat: fat_mg,
      protein: protein_mg
    }.sum { |macro, milligrams| MacroToEnergy.call(macro, milligrams) }
  end
end
