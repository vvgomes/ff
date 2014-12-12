FF::Application.routes.draw do
  match 'auth/:provider/callback',
    :to => 'sessions#create',
    :via => [:get, :post]

  match 'signout',
    :to => 'sessions#destroy',
    :as => 'signout',
    :via => [:get, :post]


  resources :users, :only => :index

  resources :accomplishments do
    resources :plus_ones
  end
  resources :suggestions

  get '/:username', :to => 'users#index', :as => 'user'
  get '/:username/stats', :to => 'stats#index', :as => 'user_stats'

  root to: 'application#index'
end
