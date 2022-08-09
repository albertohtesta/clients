# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      namespace :salesforce do
        resources :project_imports, only: [:create]
        resources :account_imports, only: [:create]
      end

      resources :managers, only: [:show] do
        scope module: :managers do
          resources :accounts, only: [:show] do
            scope module: :accounts do
              resources :account_follow_ups, only: %i[create index]
            end
          end
        end
      end

      resources :accounts, only: [:index] do
        scope module: :accounts do
          resources :contacts, only: [:index]
        end
      end

      resources :teams, only: [:index] do
        scope module: :teams do
          resources :collaborators, only: [:index]
          get "investments/:order_by" => "investments#show", as: :investments_organized
        end
      end

      resources :projects, only: [:index]
      resources :metrics, only: [:index]
      resources :posts, only: [:show]

      namespace :public do
        resources :collaborators, only: [:index, :show]
      end

      namespace :team_morale do
        resources :surveys, only: %i[index show] do
          resources :responses, only: %i[index show]
          resources :webhooks, except: %i[destroy]
        end
        resources :survey_results, only: [:index]
      end

      resources :information, only: %i[index] # TODO: DELETE THIS ENDPOINT IT'S JUST TEMPORALLY TO KNOW THE DATABASE INFORMATION IN QA
    end
  end

  get "/build-info", to: "info#build_info"
end
