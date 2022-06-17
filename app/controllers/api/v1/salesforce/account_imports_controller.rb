# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountImportsController < JwtAuthAppsController
        before_action :authenticate_request

        def create
          render json: @accounts
        end

        private

        def resource_params
          params.require(:accounts)
        end
      end
    end
  end
end
