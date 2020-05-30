# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :shopping_lists do
      add_foreign_key :user_id, :users
    end
  end
end
