# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipe_ingredients do
      add_foreign_key :ingredient_group_id, :ingredient_groups
    end
  end
end
