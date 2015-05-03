Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  

  resources :users

  resources :cooperatives do
    resources :accounts
    
    get 'admin', to: 'cooperatives#admin'
    post 'import', to: 'cooperatives#import'
    get 'accounts', to: 'cooperatives#accounts'
    get 'clear', to: 'cooperatives#clear'
    
    resources :members do
      resources :contacteds
      resources :jobs
    end
  end

  get 'info/creators'
  root 'members#index'
  
end