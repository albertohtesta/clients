# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountImportsController < JwtAuthAppsController
        before_action :authenticate_request

        def create
          @imported_accounts = Account.import(JSON.parse(resource_params, symbolize_names: true))

          render json: { accounts: @imported_accounts }, status: :created
        end

        private

        def resource_params
          params.require(:accounts)
        end
      end
    end
  end
end
