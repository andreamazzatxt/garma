Rails.application.routes.draw do
  #API ROUTES
  devise_scope :user do
    post 'api/v1/login', to: 'user/sessions#create'
    delete 'api/v1/logout', to: 'user/sessions#destroy'
  end
  get 'brands/api_all'
  get 'brands/api_by_name'
  get 'brands/api_search_barcode'
  get 'products/api_by_id'
  post 'products/api_is_favorite'
  get 'users/api_info'
  post 'users/api_update'
  get 'users/api_garderobe'
  get 'users/api_karma'
  delete 'garderobe_items/api_delete_product'
  post 'garderobe_items/api_save_product'
  ##########################
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

