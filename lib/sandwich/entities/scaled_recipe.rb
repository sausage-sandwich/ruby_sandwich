# frozen_string_literal: true

class ScaledRecipeIngredient < Delegator
  attr_accessor :recipe_ingredient
  alias_method :__getobj__, :recipe_ingredient

  def initialize(recipe_ingredient, scale)
    @recipe_ingredient = recipe_ingredient
    @scale = scale
  end

  def quantity
    @recipe_ingredient.quantity * @scale
  end
end

class ScaledRecipe < Delegator
  attr_accessor :recipe
  alias_method :__getobj__, :recipe

  def initialize(recipe, scale)
    @recipe = recipe
    @scale = scale
  end

  def recipe_ingredients
    @recipe.recipe_ingredients.map do |ri|
      ScaledRecipeIngredient.new(ri, @scale)
    end
  end
end
