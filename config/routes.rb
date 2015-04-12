RottenMangoes::Application.routes.draw do
  
  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users

  namespace :admin do
    resources :users
  end

  resource :session, only: [:new, :create, :destroy]
  root to: 'movies#index'
end
