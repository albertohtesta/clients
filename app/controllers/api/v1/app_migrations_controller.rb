# frozen_string_literal: true

module Api
  module V1
    class AppMigrationsController < JwtAuthAppsController
      before_action :authenticate_request

      # POST /api/v1/apps/accounts
      def accounts
        # Account.migrate(resource_params(:accounts))
        render json: @accounts
      end

      # POST /api/v1/apps/projects
      def projects
        # Project.migrate(resource_params(:projects))
        render json: @projects
      end

      private

      def resource_params(_resource_param)
        params.require(param_resource)
      end
    end
  end
end
