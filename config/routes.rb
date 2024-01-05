Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: { sessions: 'custom_sessions', registrations: 'registrations' }


  # Custom routes for additional user actions
  resources :users, only: [:index, :show, :update]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Define your root path route if necessary
  # root "some_controller#index"
end
