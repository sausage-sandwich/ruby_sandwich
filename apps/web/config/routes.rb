# frozen_string_literal: true

resources :recipes, only: %i[index show new create edit update]
resources :shopping_lists, only: %i[index show new create edit update]

root to: 'recipes#index'
