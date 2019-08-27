# frozen_string_literal: true

Rails.application.routes.draw do
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
    resources :iterations, except: :destroy do
      resources :check_ins do
        resources :ratings
      end
      resources :outcomes do
        resources :ratings
      end
    end
    resources :memberships, only: %i[new create index destroy]
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
