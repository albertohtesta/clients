# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class AccountsController < JwtAuthAppsController
        before_action :authenticate_request

        def import
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
