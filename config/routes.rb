# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do

      post "/app/accounts", to: "app_migrations#accounts"
      post "/auth", to: "app_auth#authenticate"
    end
  end
end