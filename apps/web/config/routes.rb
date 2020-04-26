# frozen_string_literal: true

resources :recipes, only: %i[index show new create edit update]
resources :users, only: %i[new create]
resource :session, only: %i[new create destroy]

root to: 'recipes#index'
