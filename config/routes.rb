# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Core application routes

  resources :projects do
    resources :groups
    resources :insights
    resources :assumptions do
      get 'focus'
      get 'unfocus'
      resources :responses
    end
    resources :memberships
    resources :support_messages, path: 'support' do
      get 'complete', on: :collection
    end
    get 'knowledge_board'
  end
	
  resources :programmes do
    resources :iterations do
      resources :outcomes
    end
    resources :milestones
  end
	

  # Search

  resources :search, only: [:index]

  # Focus and Reflections

  resources :foci, only: %i[index]
  resources :reflections, only: %i[new create]

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
