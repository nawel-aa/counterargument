Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/search', to: 'pages#search'

  resources :arguments, except: %i[destroy index] do
    resources :votes, only: :create
  end

  resources :tags, only: :create


  get '/profile', to: 'profiles#show'
  get '/profile/edit', to: 'profiles#edit', as: "user"
  patch '/profile/:id', to: 'profiles#update'
end
