# frozen_string_literal: true

class Recipe < Hanami::Entity
  def nutrition_facts
    ingredients.map(&:nutrition_facts).inject(:+)
  end
end
