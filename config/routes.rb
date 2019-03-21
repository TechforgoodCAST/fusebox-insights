# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'foci#index'

  resources :insights, :unknowns
  resources :reflections, only: %i[new create]

  get   '/focus',        to: 'foci#index', as: 'in_focus'
  get   '/focus/change', to: 'foci#edit',  as: 'change_focus'
  patch '/focus/change', to: 'foci#update'

  get '/reflections', to: redirect('/reflections/new')

  get  '/unknowns/:id', to: 'responses#new', as: 'unknown_responses'
  post '/unknowns/:id', to: 'responses#create'

  # create
  get '/projects/new/', to: 'projects#new', as: 'new_project'
  post '/projects/new/', to: 'projects#create', as: 'create_project'

  # retrieve
  get '/projects/', to: 'projects#index', as: 'projects'
  get '/projects/:id', to: 'projects#show', as: 'project'
  
  # update
  get '/projects/change/:id', to: 'projects#edit', as: 'edit_project'
  patch '/projects/change/:id', to: 'projects#update', as: 'change_project'

  # destroy
  delete '/projects/:id', to: 'projects#destroy', as: 'destroy_project'


  get '/projects/:project_id/support_messages/', to: 'support_messages#index', as: 'support_messages'

end
