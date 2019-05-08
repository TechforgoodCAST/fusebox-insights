# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users

  # Core application routes

  resources :projects, param: :slug do
    resources :groups
    resources :insights
    resources :assumptions, :except => [:index] do
      resources :responses
    end
    resources :project_members
    resources :support_messages
    get 'knowledge_board'
    get 'assumptions'
  end

  # Search

  resources :search, only: [:index]

  # Focus and Reflections

  resources :foci
  resources :reflections, only: %i[new create]

  # Statics

  get "privacy", to: "statics#privacy"
  get "terms", to: "statics#terms"
  get "home", to: "statics#home"

  # Root

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root to: 'statics#home'

end
