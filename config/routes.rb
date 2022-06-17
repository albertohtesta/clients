# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api do
    namespace :v1 do
      namespace :salesforce do
        resources :accounts, only: [] do
          post :import, on: :collection
        end

        resources :projects, only: [] do
          post :import, on: :collection
        end
      end

      resources :collaborators do
        get :accounts, on: :member
      end

      resources :accounts do
        get :projects, on: :member
      end

      post "/auth", to: "app_auth#authenticate"
    end
  end

  get "/build_info", to: "info#build_info"
end
