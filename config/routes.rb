Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :users

  resources :cooperatives do
    resources :members do
      resources :contacteds
      resources :jobs
    end
  end

  get 'info/creators'
  root 'members#index'
  get 'admin', to: 'cooperatives#admin'
  post 'import', to: 'cooperatives#import'

end