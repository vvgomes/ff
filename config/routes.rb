FF::Application.routes.draw do
  resources :accomplishments
  resources :plus_ones
  resources :suggestions
  devise_for :users
  get '/:username', :to => 'users#index', :as => 'user'
  root to: 'application#index'
end
