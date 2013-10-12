FF::Application.routes.draw do
  devise_for :users
  resources :accomplishments do
    resources :plus_ones
  end
  resources :suggestions
  get '/:username', :to => 'users#index', :as => 'user'
  root to: 'application#index'
end
