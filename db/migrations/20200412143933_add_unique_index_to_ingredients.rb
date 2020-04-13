# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table(:ingredients) do
      add_index :title, unique: true
    end
  end
end
