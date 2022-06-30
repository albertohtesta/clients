# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountImportsController < JwtAuthAppsController
        def create
          @imported_account = AccountRepository.import(resource_params)
          render json: { account: @imported_account }, status: :created
        rescue StandardError
          render json: { error: "Error processing data provided" }, status: :unprocessable_entity
        end

        private

        def resource_params
          resources = ActionController::Parameters.new(JSON.parse(request.raw_post, symbolize_names: true))
          account_params, opportunity_params, contacts_params = resources.require(%i[account opportunity contacts])

          {
            account: account_params,
            opportunity: opportunity_params,
            contacts: contacts_params
          }
        end
      end
    end
  end
end
