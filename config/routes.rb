Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    authenticated :user do
      root 'page#start', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :activities, except: [:index, :show]

  resources :cooperatives, only: [:edit, :update] do
    resources :accounts
    post 'import', to: 'cooperatives#import'
    get 'export', to: 'cooperatives#export'
    get 'destroy_old_members', to: 'cooperatives#destroy_old_members'
    get 'accounts', to: 'cooperatives#accounts'
  end

  resources :members, except: [:index] do
    resources :contacteds, only: [:create, :destroy]
  end

  namespace :table do
    get 'all'
  end

  namespace :page do
    get 'start'
  end

  resources :user_members, only: [:index, :destroy, :create]

  namespace :randomizer do
    get 'show'
    get 'category'
  end
end
