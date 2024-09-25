Rails.application.routes.draw do
  devise_for :users

  resource :cart, only: [ :show ] do
    post "add_to_cart/:product_id", to: "carts#add_to_cart", as: :add_to_cart
    delete "remove_from_cart/:id", to: "carts#remove_from_cart", as: :remove_from_cart
    patch "add_quantity/:id", to: "carts#add_quantity", as: :add_quantity
    patch "reduce_quantity/:id", to: "carts#reduce_quantity", as: :reduce_quantity
  end

  resources :products do
    resources :reviews, only: [ :create ] do
      resources :likes, only: [ :create, :destroy ]
    end
    collection do
      get "search"
    end
  end

  resources :orders, only: [ :create, :show, :new ]
  get "orders/:id", to: "orders#show", as: :guest_order
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "products#index"

  namespace :admin do
    get "/" => "home#index"
    resources :products
    resources :reviews do
      member do
        patch :is_published
      end
    end
  end
end
