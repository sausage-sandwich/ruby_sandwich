# frozen_string_literal: true

resources :recipes, only: %i[index show]
resources :users, only: %i[new create]
resource :session, only: %i[new create destroy]

root to: 'recipes#index'

resource :profile do
  resources :recipes
  resources :shopping_lists do
    resources :items
  end
end
post(
  '/profile/shopping_lists/add_recipe',
  to: 'profile/shopping_lists#add_recipe',
  as: :profile_shopping_list_add_recipe
)
