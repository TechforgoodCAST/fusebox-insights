# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Core application routes

  resources :projects do
    resources :iterations do
      resources :check_ins do
        resources :ratings
      end
      resources :outcomes do
        resources :ratings
      end
    end
    resources :milestones
  end

  # Statics

  get 'privacy', to: 'statics#privacy'
  get 'terms', to: 'statics#terms'
  get 'home', to: 'statics#home'

  # Root

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root to: 'statics#home'
end
