Rails.application.routes.draw do
  root 'sessions#new'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :comments
  resources :posts
  resources :users

  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :posts do
    resources :comments, only: [:create]
  end

end
