# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :insights, :unknowns
  resources :projects, param: :slug do
    resources :groups
  end
  resources :project_members, path: 'members/project/:slug'
  resources :reflections, only: %i[new create]
  resources :search, only: [:index]
  resources :support_messages, path: '/projects/:slug/support-messages'

  get   '/focus',        to: 'foci#index', as: 'in_focus'
  get   '/focus/change', to: 'foci#edit',  as: 'change_focus'
  patch '/focus/change', to: 'foci#update'

  get '/reflections', to: redirect('/reflections/new')

  get  '/unknowns/:id', to: 'responses#new', as: 'unknown_responses'
  post '/unknowns/:id', to: 'responses#create'

  get  '/projects/:project_slug/groups/:id/:unknown_id', to: 'groups#detach', as: 'detach_group'

  get "privacy", to: "statics#privacy"
  get "terms", to: "statics#terms"
  get "home", to: "statics#home"

  authenticated :user do
    root 'foci#index', as: :authenticated_root
  end

  root to: 'statics#home'

end
