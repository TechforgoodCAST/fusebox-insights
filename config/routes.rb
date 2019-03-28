# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'foci#index'

  resources :insights, :unknowns
  resources :projects, param: :slug
  resources :reflections, only: %i[new create]
  resources :search, only: [:index]
  resources :support_messages, path: '/projects/:slug/support-messages/'

  resources :groups do
    member do 
      get 'detach'
    end
  end

  get   '/focus',        to: 'foci#index', as: 'in_focus'
  get   '/focus/change', to: 'foci#edit',  as: 'change_focus'
  patch '/focus/change', to: 'foci#update'

  get '/reflections', to: redirect('/reflections/new')

  get  '/unknowns/:id', to: 'responses#new', as: 'unknown_responses'
  post '/unknowns/:id', to: 'responses#create'
end
