# frozen_string_literal: true

class NutritionFacts < Hanami::Entity
  attributes do
    attribute :carbohydrates_mg, Types::Strict::Int.default(0)
    attribute :fat_mg, Types::Strict::Int.default(0)
    attribute :protein_mg, Types::Strict::Int.default(0)
  end

  def calories
    {
      carbohydrates: carbohydrates_mg,
      fat: fat_mg,
      protein: protein_mg
    }.sum { |macro, milligrams| MacroToEnergy.call(macro, milligrams) }
  end

  def +(other)
    self.class.new(
      carbohydrates_mg: carbohydrates_mg + other.carbohydrates_mg,
      fat_mg: fat_mg + other.fat_mg,
      protein_mg: protein_mg + other.protein_mg
    )
  end
end
