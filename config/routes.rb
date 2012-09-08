FF::Application.routes.draw do
  devise_for :users

  resources :accomplishments
  resources :users

  root to: 'users#index'
end
