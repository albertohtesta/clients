# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      namespace :salesforce do
        resources :project_imports, only: [:create]
        resources :account_imports, only: [:create]
      end

      resources :collaborators do
        resources :accounts, only: [:show] do
          resources :projects, only: [:show]
        end
      end

      resources :app_auth, only: [:create]
    end
  end

  get "/build-info", to: "info#build_info"
end
