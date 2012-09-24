FF::Application.routes.draw do
  devise_for :users

  resources :accomplishments
  resources :suggestions
  resources :users

  get '/:username', :to => 'accomplishments#index', :as => :user

  root to: 'accomplishments#index'
end
