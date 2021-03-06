# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :recipes do
      primary_key :id
      column :title, String, null: false
      column :body, String, text: true, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
