# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :recipe_ingredients do
      primary_key :id
      foreign_key :recipe_id, :recipes, on_delete: :cascade, null: false
      foreign_key :ingredient_id, :ingredients, on_delete: :cascade, null: false
      column :quantity, BigDecimal, default: 0.0
      column :unit, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
