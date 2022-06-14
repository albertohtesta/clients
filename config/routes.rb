# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :account_migrations do
        post 'accounts'
        post 'projects'
      end
    end
  end

  get "/build_info", to: "info#build_info"
end