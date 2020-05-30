# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :shopping_list_items do
      primary_key :id
      foreign_key :ingredient_id, :ingredients, on_delete: :cascade
      foreign_key :shopping_list_id, :shopping_lists, on_delete: :cascade, null: false
      column :title, String
      column :quantity, BigDecimal
      column :unit, String
      column :checked, FalseClass, default: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
