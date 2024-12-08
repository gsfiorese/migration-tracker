Rails.application.routes.draw do

  # Routes for user_admin namespace
  namespace :user_admin do
    get "log/index", to: "log#index", as: "log_index"
    get "welcome/index", to: "welcome#index", as: "welcome_index"

    # Add routes for ImportController under user_admin namespace.
    get "import/index", to: "import#index", as: "import_index"
    post "import/upload", to: "import#upload", as: "import_upload"
    post "import/process_import", to: "import#process_import", as: "import_process_import"

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
      resources :visas, except: %i[index edit show update destroy]
    end
    resources :visas, only: %i[index edit show update destroy]
  end

  # Routes for user_member namespace
  namespace :user_member do
    get "welcome/index", to: "welcome#index", as: "welcome_index"

    # Add routes for YearlyMigrationData under user_member (if needed for direct access)
    resources :yearly_migration_data, only: [:index]

    resources :anzsco_codes

    # Member-specific visa_categories with nested visas
    resources :visa_categories, only: [:index, :show] do
      resources :visas, only: [:index] do  # N  \ested route for visas related to a specific category
        resources :comments, only: [:create], controller: 'comments' # Create comments for visas
      end
    end

    # Add namespace for YearlyMigration
    namespace :yearly_migration do
      resources :yearly_migration_data, only: [:index] do
        collection do
          get :fetch_tab_data # Route for AJAX-based tab functionality
        end
      end
    end

    resources :visas, only: [:index] do # Global list of visas for members (optional if needed)
      resources :comments, only: [:create], controller: 'comments' # Create comments for visas (alternative route)
    end


    resources :cases, only: [:index, :new, :create, :show] do
      resources :comments, only: [:create], controller: 'comments' # Nested route for comments on cases
    end
  end

  # Route for welcome page (root)
  root "welcome#index"

  # Routes for footer headings
  get '/about', to: 'pages#about', as: 'about'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/employment', to: 'pages#employment', as: 'employment'
  get '/resources', to: 'pages#resources', as: 'resources'
  get '/privacy-policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  get '/terms-of-service', to: 'pages#terms_of_service', as: 'terms_of_service'

  # Route from welcome page to user/member page

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
