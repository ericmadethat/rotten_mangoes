RottenMangoes::Application.routes.draw do
  resources :movies
  resources :users, only: [:new, :create]
end
