# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :ingredients do
      add_column :carbohydrates_mg, Integer
      add_column :fat_mg, Integer
      add_column :protein_mg, Integer
    end
  end
end
