Rails.application.routes.draw do

  # routes to user_admin
  namespace :user_admin do
    get "log/index", to: "log#index", as: "log_index"
    get 'welcome/index', to: 'welcome#index', as: 'welcome_index'
  end

  # route to welcome page (root)
  root 'welcome#index'

  # route from welcome page to user/member page
  get '/user_admin', to: 'user_admin#index', as: :user_admin_index
  get '/user_member', to: 'user_member#index', as: :user_member_index

  # configuration for devise to work with omniauth (google)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
