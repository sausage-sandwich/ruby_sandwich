# frozen_string_literal: true

class ShoppingListRepository < Hanami::Repository
  associations do
    has_many :shopping_list_items
    has_many :ingredients, through: :shopping_list_items
  end

  def find_with_items(id)
    aggregate(shopping_list_items: :ingredient).where(id: id).map_to(ShoppingList).one
  end
end
