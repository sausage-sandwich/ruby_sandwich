# frozen_string_literal: true

resources :ingredients, only: %i[index edit update]

root to: 'ingredients#index'
