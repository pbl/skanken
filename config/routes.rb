Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    authenticated :user do
      root 'table#all', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :activities, except: [:index, :show] do
    get 'deactivate', to: 'activities#deactivate'
  end

  resources :cooperatives, only: [:edit, :update] do
    resources :accounts
    post 'import', to: 'cooperatives#import'
    get 'destroy_old_members', to: 'cooperatives#destroy_old_members'
    get 'accounts', to: 'cooperatives#accounts'
  end

  resources :members, except: [:index] do
    resources :jobs, only: [:create, :destroy]
    resources :contacteds, only: [:create, :destroy]
  end

  namespace :table do
    get 'choose'
    get 'create'
    get 'all'
  end

  get 'history', to: 'history#show'

  namespace :randomizer do
    get 'show'
    get 'category'
  end
end
