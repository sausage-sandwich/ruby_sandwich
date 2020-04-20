# frozen_string_literal: true

resources :recipes
resources :shopping_lists do
  resources :items
end

root to: 'recipes#index'
