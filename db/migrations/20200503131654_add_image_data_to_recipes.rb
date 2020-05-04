# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :recipes do
      add_column :image_data, String, text: true
    end
  end
end
