# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :admin, FalseClass, null: false, default: false
    end
  end
end
