# frozen_string_literal: true

resources :ingredients, only: %i[index edit update] do
  resources :conversions, only: %i[index]
end
resources :users, only: %i[index]

root to: 'ingredients#index'
