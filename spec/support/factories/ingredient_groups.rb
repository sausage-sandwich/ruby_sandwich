# frozen_string_literal: true

class Factory
  class IngredientGroups
    def self.call(**args)
      new(**args).call
    end

    attr_reader :params

    def initialize(**args)
      @params = args.fetch(:params, {})
    end

    def call
      repo.create(generated_params.merge(params).merge(recipe_id: recipe_id))
    end

    private

    def recipe_id
      if params.fetch(:recipe_id, nil)
        params.fetch(:recipe_id, nil)
      else
        Factory::Recipes.call.id
      end
    end

    def generated_params
      {
        title: "title#{rand(100_000)}"
      }
    end

    def repo
      IngredientGroupRepository.new
    end
  end
end
