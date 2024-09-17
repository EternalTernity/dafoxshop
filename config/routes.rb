Rails.application.routes.draw do
  devise_for :users
  resources :addresses
  get "carts", to: "carts#show"
  resources :carts do
    member do
      get "/new_cart", to: "carts#new", as: "new_cart"
      match "/add_to_cart/:product_id", action: :add_to_cart, via: [ :get, :post ], as: "add_to_cart"
      match "/remove_from_cart/:product_id", action: :remove_from_cart, via: [ :get, :delete ], as: "remove_from_cart"

      # add and reduce
      match "/add_quantity/:product_id", action: :add_quantity, via: [ :get, :patch ], as: "add_quantity"
      match "/reduce_quantity/:product_id", action: :reduce_quantity, via: [ :get, :patch ], as: "reduce_quantity"

      # delete all
      match "clear_all_carts", via: [ :get, :post ]
    end
  end
  resources :products do
    resources :reviews, except: [ :index ]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  namespace :admin do
    get "/" => "home#index"
    resources :products
  end
end
