Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/cookbook', to: 'pages#cookbook', as: :cookbook
  get '/choose_category', to: 'pages#choose_category', as: :choose_category
  post '/assign_category', to: 'pages#assign_category', as: :assign_category
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/profile', to: 'pages#profile', as: :profile
  resources :categories, only: %I(show)
  resources :challenges, only: %I(show) do
    resources :recipes, only: %I(index)
  end
  resources :recipes, only: %I(show)

  get 'recipes/all', to: 'recipes#all', as: :all_recipes
end
