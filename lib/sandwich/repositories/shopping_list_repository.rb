# frozen_string_literal: true

class ShoppingListRepository < Hanami::Repository
  associations do
    has_many :shopping_list_items
    has_many :ingredients, through: :shopping_list_items
  end

  def find_with_items(id:, user_id:)
    aggregate(shopping_list_items: :ingredient).
      where(id: id, user_id: user_id).
      map_to(ShoppingList).
      one
  end

  def find_by_id_and_user_id(id:, user_id:)
    shopping_lists.
      where(id: id, user_id: user_id).
      map_to(ShoppingList).
      one
  end

  def by_user(user_id:)
    shopping_lists.where(user_id: user_id)
  end
end
