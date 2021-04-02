# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :ingredient_groups do
      primary_key :id
      column :title, String
      foreign_key :recipe_id, :recipes, on_delete: :cascade, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
