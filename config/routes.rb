Rails.application.routes.draw do
  get 'user/new'
  get 'product/show'
  get 'brands/index'
  devise_for :users
  root to: 'pages#home'

  resources :brands, only: [:index] do
    member do
      get 'scan/', to: 'brands#scan', as: 'scan'
      get 'type/', to: 'brands#type', as: 'type'
      post 'search'
      post 'type_search'
    end
  end
  resources :products, only: [:show] do
    resources :garderobe_items, only: [:create]
  end
  resources :garderobe_items, only: [:destroy]
  resources :users, only: [:show, :edit, :update, :new, :create] do
    resources :products, only: [:index]
  end

  get 'profile', to: 'pages#profile'
  get 'about', to: 'pages#about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
