# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountImportsController < JwtAuthAppsController
        def create
          @imported_accounts = AccountRepository.import(JSON.parse(resource_params, symbolize_names: true))
          render json: { accounts: @imported_accounts }, status: :created
        rescue StandardError
          render json: { error: "Invalid Data Provided" }, status: :unprocessable_entity
        end

        private

        def resource_params
          params.require(:accounts)
        end
      end
    end
  end
end
