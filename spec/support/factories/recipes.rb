# frozen_string_literal: true

require_relative '../helpers/repositories'

class Factory
  class Recipes
    include ::Helpers::Repositories

    def self.call(**args)
      new(**args).call
    end

    attr_reader :params

    def initialize(**args)
      @params = args.fetch(:params, {})
    end

    def call
      recipe = recipe_repo.create(generated_params.merge(params).merge(user_id: user_id))
      ingredient_group = Factory::IngredientGroups.call(params: { recipe_id: recipe.id })
      recipe_ingredients_params.each do |recipe_ingredient_params|
        recipe_ingredient_repo.create(
          recipe_ingredient_params.merge(
            ingredient_group_id: ingredient_group.id,
            recipe_id: recipe.id
          )
        )
      end
      recipe_repo.find_with_ingredient_groups(recipe.id)
    end

    private

    def user_id
      return params.fetch(:user_id, nil) if params.fetch(:user_id, nil)

      Factory::Users.call.id
    end

    def generated_params
      {
        title: "title#{rand(100_000)}",
        body: 'body'
      }
    end

    def recipe_ingredients_params
      ingredient = Factory::Ingredients.call

      [{
        ingredient: ingredient,
        ingredient_id: ingredient.id,
        unit: 'g',
        quantity: 100.0
      }]
    end
  end
end
