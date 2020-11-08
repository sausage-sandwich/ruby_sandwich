# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :ingredient_conversions do
      primary_key :id

      foreign_key :ingredient_id, :ingredients, on_delete: :cascade, null: false
      column :unit, String, null: false
      column :weight_mg, BigDecimal, null: false, default: 0

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end

    alter_table :ingredient_conversions do
      add_index %i[ingredient_id unit], unique: true
    end
  end
end
