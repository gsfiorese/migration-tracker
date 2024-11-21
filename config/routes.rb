Rails.application.routes.draw do
    # Root route for admins/countries#index
    # root 'admins/countries#index'

    # Admins namespace with countries resource
    namespace :admins do
      resources :countries, only: [:index, :show, :new, :create, :edit, :update, :destroy]
      resources :users, only: [:index, :edit, :update, :destroy]
    end
    # Admins namespace with users resource
    # namespace :admins do
      # resources :users, only: [:index, :edit, :update, :destroy]
    # end

    # Devise user routes for authentication
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

    # Health check route for uptime monitoring
    get "up" => "rails/health#show", as: :rails_health_check

    # PWA dynamic files routes
    get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
    get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

    # Any other routes can be defined below as necessary
  end
