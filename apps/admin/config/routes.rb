# frozen_string_literal: true

resources :ingredients, only: %i[index edit update]
resources :users, only: %i[index]

root to: 'ingredients#index'
