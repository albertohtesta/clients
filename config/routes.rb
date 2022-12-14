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
          resources :accounts, only: [:show, :index] do
            scope module: :accounts do
              resources :collaborators, only: [:destroy], param: "collaborator_id"
              resources :account_follow_ups, only: %i[create index]
            end
          end
        end
      end

      resources :accounts, only: %i[index show] do
        scope module: :accounts do
          resources :contacts, only: %i[index show]
          resources :contacts_collaborators, only: %i[index]
          resources :invitations, only: [:create]
          resources :customers_information, only: %i[index]
          resources :teams, only: %i[index]
        end
      end

      resources :teams, only: [:index] do
        scope module: :teams do
          resources :collaborators, only: [:index]
          resources :investments, only: [:index] do
            get :years, on: :collection
          end
          resources :metrics, only: [:index]
        end
      end

      resources :projects, only: [:index]
      resources :posts, only: [:show]

      namespace :public do
        resources :collaborators, only: %i[index show]
      end

      namespace :team_morale do
        resources :surveys, only: %i[create index show destroy] do
          resources :responses, only: %i[index show]
          resources :webhooks, except: %i[destroy]
        end
        resources :survey_results, only: [:index]
        resources :remote_surveys, only: %i[index show update create]
        resources :survey_questions, only: [:index]
        resources :morale_attributes, only: [:index]
      end

      resources :metric_history, only: %i[show update]
      put "/metric_history", to: "metric_history#update"

      namespace :team_balance do
        resources :balances, only: %i[index]
      end

      resources :information, only: %i[index] # TODO: DELETE THIS ENDPOINT IT'S JUST TEMPORALLY TO KNOW THE DATABASE INFORMATION IN QA
    end
  end

  get "/build-info", to: "info#build_info"
end
