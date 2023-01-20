Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[index new create]
  resources :subs, except: [:destroy]
  resources :posts, only: %i[new create edit update show]
  resource :session, only: %i[new create destroy]
end
