# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipe_ingredients do
      add_column :title, String, default: nil
    end
  end
end
