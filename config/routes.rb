# frozen_string_literal: true

Rails.application.routes.draw do
  # Admin

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Sessions

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # Core application routes

  resources :projects, except: :destroy do
    member do
      get :about
      get :share, to: 'memberships#show'
    end
    # TODO: https://guides.rubyonrails.org/routing.html#limits-to-nesting
    resources :iterations do
      resources :check_ins do
        resources :check_in_ratings
      end
      resources :debriefs do
        resources :debrief_ratings
      end
      resources :outcomes do
        resources :check_in_ratings
      end
    end
    resources :memberships, only: %i[new create index destroy]
    resources :milestones
    resources :offers, only: %i[show book] do
      get :book, to: 'support_requests#new'
      resources :support_requests, only: %i[new create]
    end
    resources :topics, only: %i[show index]
  end
  resources :cohorts, only: %i[show index]

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
