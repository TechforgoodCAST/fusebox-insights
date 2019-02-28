# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'foci#index'

  resources :insights, :unknowns
  resources :reflections, only: %i[new create]
  resources :search, only: [:index]

  get   '/focus',        to: 'foci#index', as: 'in_focus'
  get   '/focus/change', to: 'foci#edit',  as: 'change_focus'
  patch '/focus/change', to: 'foci#update'

  get '/reflections', to: redirect('/reflections/new')

  get  '/unknowns/:id', to: 'comments#new', as: 'unknown_comments'
  post '/unknowns/:id', to: 'comments#create'
end
