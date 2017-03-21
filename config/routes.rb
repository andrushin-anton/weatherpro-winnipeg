Rails.application.routes.draw do
  
  resources :administrators
  resources :managers
  resources :sellers
  resources :installers
  resources :customers
  resources :sessions
  resources :users
  resources :articles

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'users/password/:id', to: 'users#password', as: 'password'
  get 'logs', to: 'logs#index'
  patch 'users/update_password/:id', to: 'users#update_password', as: 'update_password'
  patch 'users/activate/:id', to: 'users#activate', as: 'user_activate'

  root to: 'articles#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
