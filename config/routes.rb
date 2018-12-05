# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'foci#index'

  resources :insights, :unknowns

  get '/focus', to: 'foci#index', as: 'in_focus'
end
