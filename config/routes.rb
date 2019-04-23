# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects, param: :slug do
    resources :groups
    resources :insights
    resources :unknowns
    resources :project_members
    resources :support_messages
    get 'knowledge_board'
  end

  get  '/unknowns/:id', to: 'responses#new', as: 'unknown_responses'
  post '/unknowns/:id', to: 'responses#create'
  get  '/projects/:project_slug/groups/:id/:unknown_id', to: 'groups#detach', as: 'detach_group'

  resources :search, only: [:index]

  get   '/focus',        to: 'foci#index', as: 'in_focus'
  get   '/focus/change', to: 'foci#edit',  as: 'change_focus'
  patch '/focus/change', to: 'foci#update'

  resources :reflections, only: %i[new create]
  get '/reflections', to: redirect('/reflections/new')

  get "privacy", to: "statics#privacy"
  get "terms", to: "statics#terms"
  get "home", to: "statics#home"

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root to: 'statics#home'

end
