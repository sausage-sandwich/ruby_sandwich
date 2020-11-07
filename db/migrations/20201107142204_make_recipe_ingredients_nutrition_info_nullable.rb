# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipe_ingredients do
      set_column_default :carbohydrates_mg, nil
      set_column_default :fat_mg, nil
      set_column_default :protein_mg, nil
    end
  end
end
