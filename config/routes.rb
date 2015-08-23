Rails.application.routes.draw do


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }


  resources :activities, except: [:index, :show] do
    get 'deactivate', to: 'activities#deactivate'
  end
  # resources :users

  resources :cooperatives, only: [:edit, :update] do
    resources :accounts

    post 'import', to: 'cooperatives#import'
    get 'accounts', to: 'cooperatives#accounts'

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

  get 'history', to: 'history#show'

  # get 'pages/about'
  root 'pages#start'

  namespace :charts do
    get 'member_created_date'
  end
end
