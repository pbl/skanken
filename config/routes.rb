Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: "users/registrations"
  }


  resources :activities, except: [:index, :show]
  # resources :users

  resources :cooperatives, only: [:edit, :update] do
    resources :accounts

    get 'admin', to: 'cooperatives#admin'
    post 'import', to: 'cooperatives#import'
    get 'accounts', to: 'cooperatives#accounts'
    get 'clear', to: 'cooperatives#clear'

  end
  resources :members, except: [:index] do
    resources :jobs, only: [:create, :destroy]
    resources :contacteds, only: [:destroy]
    get 'add', to: 'contacteds#add'
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