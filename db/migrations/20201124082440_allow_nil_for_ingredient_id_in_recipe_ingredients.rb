# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipe_ingredients do
      set_column_allow_null :ingredient_id
    end
  end
end
