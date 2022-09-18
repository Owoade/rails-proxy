Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root "users#index"
      post 'users/create', to: "users#create"
      post 'users/auth', to: "users#auth"
      get "users/service", to: "users#service"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
