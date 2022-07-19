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
          resources :contacts, only: [:index]
          resources :projects, only: [:show]
          resources :account_follow_ups, only: %i[create index]
        end
      end

      resources :collaborators do
        resources :posts, only: [:show]
      end

      namespace :account do
        resources :collaborators
      end

      resources :metrics, only: [:index]
      resources :app_auth, only: [:create]
    end
  end

  get "/build-info", to: "info#build_info"
end
