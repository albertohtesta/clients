# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api do
    namespace :v1 do

      #salesforce from data
      post "/app/accounts", to: "app_migrations#accounts"
      post "/app/products", to: "app_migrations#products"


      resources :collaborators do
        get :accounts, on: :member
      end

      get "/accounts/:id/projects", to: "accounts#projects"

      post "/auth", to: "app_auth#authenticate"
    end
  end

  get "/build_info", to: "info#build_info"
end