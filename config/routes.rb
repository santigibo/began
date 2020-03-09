Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/meat_counter', to: 'pages#meat_counter', as: :meat_counter
  get '/cookbook', to: 'pages#cookbook', as: :cookbook
  get '/choose_cookbook', to: 'pages#choose_cookbook', as: :choose_cookbook

  get '/choose_category', to: 'pages#choose_category', as: :choose_category
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/profile', to: 'pages#profile', as: :profile
  resources :categories, only: %I(show)
  resources :challenges, only: %I(show) do
    resources :questions, only: %I(index) do
      resources :question_completions, only: %I(create)
    end
    resources :recipes, only: %I(index)
    resources :challenge_completions, only: %I(create)
  end
  resources :recipes, only: %I(show) do
      post '/create_or_destroy', to: 'user_recipes#create_or_destroy', as: :create_or_destroy
  end

  resources :user_recipes, only: %I(destroy)
  resources :posts, only: %I(index show create update destroy) do
    resources :comments, only: %I(create)
  end

  resources :questions, only: [] do
    resources :question_completions, only: %I(create)
  end
  get '/all_recipes', to: 'recipes#all', as: :all_recipes
end
