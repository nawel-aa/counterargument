Rails.application.routes.draw do
  devise_for :users

  # devise_scope :user do
  #   get '/users', to: 'devise/registrations#new'
  #   get '/users/password', to: 'devise/passwords#new'
  # end


  root to: 'pages#home'
  get '/search', to: 'pages#search'

  resources :arguments, except: %i[destroy index] do
    resources :votes, only: :create
  end

  patch '/notifications/:id', to: 'notifications#update', as: 'update_notification'

  get '/profile/visit/:id', to: 'profiles#visit', as: 'visit_profile'

  resources :tags, only: :create

  get '/profile', to: 'profiles#show'
  get '/profile/edit', to: 'profiles#edit', as: "user"
  patch '/profile/:id', to: 'profiles#update'

  # API created for Sigma
  namespace :api, defaults: { format: :jason } do
    namespace :v1 do
      resources :sigma_arguments, only: :index
    end
  end
end
