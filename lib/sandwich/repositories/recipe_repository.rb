# frozen_string_literal: true

class RecipeRepository < Hanami::Repository
  associations do
    belongs_to :user
    has_many :recipe_ingredients, through: :ingredient_groups
    has_many :ingredients, through: :recipe_ingredients
    has_many :ingredient_groups
  end

  def by_user(user_id)
    recipes.where(user_id: user_id).order(Sequel.desc(:created_at))
  end

  def latest
    recipes.order(Sequel.desc(:created_at))
  end

  def page(page_number = 1)
    limit = 16
    recipes.order(Sequel.desc(:created_at)).limit(limit).offset(limit * (page_number - 1))
  end

  def find_with_ingredients(id)
    aggregate(:ingredients, recipe_ingredients: :ingredient).where(id: id).map_to(Recipe).one
  end

  def find_with_ingredient_groups(id)
    aggregate(
      :user,
      :ingredients,
      recipe_ingredients: :ingredient,
      ingredient_groups: {
        recipe_ingredients: :ingredient
      }
    ).where(id: id).map_to(Recipe).one
  end

  def find_with_ingredients_for_user(recipe_id, user_id)
    aggregate(:ingredients, recipe_ingredients: :ingredient).
      where(id: recipe_id, user_id: user_id).
      map_to(Recipe).
      one
  end

  def all_with_ingredients
    aggregate(recipe_ingredients: :ingredient).map_to(Recipe)
  end
end
