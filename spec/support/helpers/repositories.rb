# frozen_string_literal: true

module Helpers
  module Repositories
    def recipe_repo
      @recipe_repo ||= RecipeRepository.new
    end

    def recipe_ingredient_repo
      @recipe_ingredient_repo ||= RecipeIngredientRepository.new
    end

    def ingredient_group_repo
      @ingredient_group_repo ||= IngredientGroupRepository.new
    end

    def ingredient_repo
      @ingredient_repo ||= IngredientRepository.new
    end

    def user_repo
      @user_repo ||= UserRepository.new
    end
  end
end
