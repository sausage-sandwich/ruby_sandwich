# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipe_ingredients do
      add_column :carbohydrates_mg, BigDecimal, default: 0
      add_column :fat_mg, BigDecimal, default: 0
      add_column :protein_mg, BigDecimal, default: 0
    end
  end
end
