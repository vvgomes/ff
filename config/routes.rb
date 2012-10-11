FF::Application.routes.draw do
  resources :accomplishments
  resources :suggestions
  resources :thumbs_ups
  devise_for :users
  get '/:username', :to => 'users#index', :as => 'user'
  root to: 'application#index'
end
