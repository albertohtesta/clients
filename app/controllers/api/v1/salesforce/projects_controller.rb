# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class ProjectsController < JwtAuthAppsController
        before_action :authenticate_request

        # POST /api/v1/salesforce/projects/import
        def index
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
end
