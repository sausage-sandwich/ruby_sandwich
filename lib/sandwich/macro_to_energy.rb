# frozen_string_literal: true

##
# Converts specified amount of a macronutrient element to the amount of energy
# in calories. Information was taken from https://www.nal.usda.gov/fnic/how-many-calories-are-one-gram-fat-carbohydrate-or-protein
module MacroToEnergy
  ENERGY_BY_MACROS = {
    carbohydrates: 4,
    fat: 9,
    protein: 4
  }.freeze

  module_function

  def call(macro_name, milligrams)
    energy = ENERGY_BY_MACROS.fetch(macro_name)
    weight = Metric.mg_to_g(milligrams)

    energy * weight
  end
end
