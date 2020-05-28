# frozen_string_literal: true

class Factory
  class Recipes
    def self.call(**args)
      new(**args).call
    end

    attr_reader :params

    def initialize(**args)
      @params = args.fetch(:params, {})
    end

    def call
      recipe = repo.create_with_recipe_ingredients(generated_params.merge(params))
      repo.find_with_ingredients(recipe.id)
    end

    private

    def generated_params
      {
        title: "title#{rand(100_000)}",
        body: 'body',
        recipe_ingredients: {
          ingredient: ingredient,
          ingredient_id: ingredient.id,
          unit: 'g',
          quantity: 100.0
        }
      }
    end

    def ingredient
      @ingredient = Factory::Ingredients.call
    end

    def repo
      RecipeRepository.new
    end
  end
end
