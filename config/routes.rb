Rails.application.routes.draw do
  get 'product/show'
  devise_for :users
  root to: 'pages#home'

  resources :brands, only: [:index] do
    collection do
      get ':brand_id/scan/', to: 'brands#scan', as: 'scan'
      post 'search'
    end
  end
  resources :products, only: [:show] do
    resources :garderobe_items, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :new, :create] do
    resources :products, only: [:index]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
