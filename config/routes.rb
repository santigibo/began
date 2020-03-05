Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/meat_counter', to: 'pages#meat_counter', as: :meat_counter
  get '/cookbook', to: 'pages#cookbook', as: :cookbook
  get '/choose_category', to: 'pages#choose_category', as: :choose_category
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/profile', to: 'pages#profile', as: :profile
  resources :categories, only: %I(show)
  resources :challenges, only: %I(show) do
    resources :questions, only: %I(index)
    resources :recipes, only: %I(index)
    resources :challenge_completions, only: %I(create)
  end
  resources :recipes, only: %I(show) do
      resources :user_recipes, only: %I(create)
  end
  resources :questions, only: [] do
    resources :question_completions, only: %I(create)
  end
  get '/all_recipes', to: 'recipes#all', as: :all_recipes
end
