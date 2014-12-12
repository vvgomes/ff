FF::Application.routes.draw do
  resources :users, :only => :index

  resources :accomplishments do
    resources :plus_ones
  end
  resources :suggestions

  get '/:username', :to => 'users#index', :as => 'user'
  get '/:username/stats', :to => 'stats#index', :as => 'user_stats'

  root to: 'application#index'
end
