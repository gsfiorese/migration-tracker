Rails.application.routes.draw do
  # Routes for user_admin namespace
  namespace :user_admin do
    get "log/index", to: "log#index", as: "log_index"
    get "welcome/index", to: "welcome#index", as: "welcome_index"

    # Add routes for YearlyMigrationData under user_admin (if needed for direct access)
    resources :yearly_migration_data, only: [:index]

    # Add routes for ANZSCO countries
    resources :countries, only: [:index, :show, :new, :create, :edit, :update, :destroy]

    # Add routes for ANZSCO Code
    resources :anzsco_codes

    # Add routes for user
    resources :users

    # Add routes for visa category and visa
    resources :visa_categories do
      resources :visas, except: %i[index] # Admins have full access except nested index
    end
    resources :visas, only: %i[index edit show update destroy] # Admins manage visas globally
  end

  # Routes for user_member namespace
  namespace :user_member do
    get "welcome/index", to: "welcome#index", as: "welcome_index"

    # Add routes for YearlyMigrationData under user_member (if needed for direct access)
    resources :yearly_migration_data, only: [:index]

    # Member-specific visa_categories with nested visas
    resources :visa_categories, only: [:index, :show] do
      resources :visas, only: [:index] # Nested route for visas related to a specific category
    end

    resources :visas, only: [:index] # Global list of visas for members (optional if needed)
  end

  # Route for welcome page (root)
  root "welcome#index"

  # Routes for user roles redirection
  get "/user_admin", to: "user_admin#index", as: :user_admin_index
  get "/user_member", to: "user_member#index", as: :user_member_index

  # Add YearlyMigrationDataController routes at the root level (if needed for welcome#index)
  resources :yearly_migration_data, only: [:index]

  # Configuration for Devise to work with Omniauth (Google)
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
