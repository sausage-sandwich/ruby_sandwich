# frozen_string_literal: true

resources :recipes, only: %i[index show new create edit update]
resources :users, only: %i[new create]

root to: 'recipes#index'
