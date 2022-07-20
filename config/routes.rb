# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      namespace :salesforce do
        resources :project_imports, only: [:create]
        resources :account_imports, only: [:create]
      end

      resources :managers do
        resources :accounts, only: [:show] do
          resources :account_follow_ups, only: %i[create index]
        end
      end

      resources :accounts do
        resources :contacts, only: [:index]
        resources :projects
      end

      resources :projects do
        resources :collaborators, only: [:index]
      end

      resources :collaborators do
        resources :posts
      end

      resources :posts, only: [:show]
      resources :metrics, only: [:index]
    end
  end

  get "/build-info", to: "info#build_info"
end
