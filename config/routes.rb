FF::Application.routes.draw do
  resources :accomplishments
  resources :users

  root to: 'users#index'
end
