# frozen_string_literal: true

class ShoppingListItemRepository < Hanami::Repository
  associations do
    belongs_to :shopping_list
    belongs_to :ingredient
  end

  def find_by_shopping_list(shopping_list_id, shopping_list_item_id)
    shopping_list_items.
      where(id: shopping_list_item_id, shopping_list_id: shopping_list_id).
      map_to(ShoppingListItem).
      one
  end

  def find_by_list_and_title(id, title)
    shopping_list_items.where(
      shopping_list_id: id,
      title: title
    ).one
  end
end
