# frozen_string_literal: true

resources :recipes, only: %i[index show new create]

root to: 'recipes#index'
