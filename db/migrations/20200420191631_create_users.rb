# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :name, String
      column :email, String
      column :password_digest, String
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
