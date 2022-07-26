# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      namespace :salesforce do
        resources :project_imports, only: [:create]
        resources :account_imports, only: [:create]
      end

      resources :managers, only: [:show] do
        resources :accounts, only: [:show] do
          resources :account_follow_ups, only: %i[create index]
        end
      end

      resources :accounts, only: [:index] do
        resources :contacts, only: [:index]
        resources :projects, only: [:index]
      end

      resources :projects, only: [:index] do
        resources :investments, only: [:show]
        resources :collaborators, only: [:index]
      end

      resources :collaborators, only: [:index] do
        resources :posts, only: [:index]
      end

      resources :teams, only: [:index] do
        resources :collaborators, only: [:index]
          get 'investments/:order_by' => 'investments#show', as: :investments_organized
      end

      resources :posts, only: [:show]
      resources :metrics, only: [:index]

    end
  end

  get "/build-info", to: "info#build_info"
end
