# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountsController < JwtAuthAppsController
        before_action :authenticate_request

        # POST /api/v1/salesforce/accounts/import
        def import
          render json: @accounts
        end

        private

        def resource_params(_resource_param)
          params.require(param_resource)
        end
      end
    end
  end
end
