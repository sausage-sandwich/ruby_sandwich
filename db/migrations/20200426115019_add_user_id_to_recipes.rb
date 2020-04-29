# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipes do
      add_foreign_key :user_id, :users
    end
  end
end
