Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: "users/registrations"
  }


  resources :activities
  resources :users

  # resources :tables

  resources :cooperatives do
    resources :accounts

    get 'admin', to: 'cooperatives#admin'
    post 'import', to: 'cooperatives#import'
    get 'accounts', to: 'cooperatives#accounts'
    get 'clear', to: 'cooperatives#clear'

  end
  resources :members do
    resources :contacteds
    resources :jobs
  end

  namespace :table do
    get 'choose'
    get 'create'
    get 'table'
  end
  # get 'choose', to: 'table#choose'
  # get 'create', to: 'table#create'

  get 'pages/about'
  root 'pages#start'

end