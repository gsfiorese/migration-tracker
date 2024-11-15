Rails.application.routes.draw do
  root "welcome#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Admin routes (admin-only section)
  namespace :admin do
    get "dashboard/index"
    # Admin dashboard
    get "dashboard", to: "dashboard#index", as: :dashboard
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "/favicon.ico", to: redirect("/assets/favicon.ico")

  # Defines the root path route ("/")
  # root "posts#index"

  # Admin-only section
  namespace :admin do
    resources :dashboard, only: [:index] # To adjust
  end
end
