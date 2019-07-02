Rails.application.routes.draw do
  root 'events#index'

  get       '/signup',       to: 'users#new'
  post      '/signup',       to: 'users#create'
  get       '/login',        to: 'sessions#new'
  post      '/login',        to: 'sessions#create'
  delete    '/logout',       to: 'sessions#destroy'
  resources 'users',         only: [:new, :create, :show]
  resources 'sessions',      only: [:new]
  resources 'events',        only: [:index, :new, :create] do
    resources 'attendances', only: [:index, :create]
  end
end
