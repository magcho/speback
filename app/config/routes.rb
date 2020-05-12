Rails.application.routes.draw do
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/guide'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'

  # twitter login
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users
  resources :slides
  resources :events do
    resources :hashtags
  end
end
