# frozen_string_literal: true

module Api
  module V1
    module Salesforce
      class ProjectImportsController < JwtAuthAppsController
        before_action :authenticate_request

        def create
          render json: @projects
        end

        private

        def resource_params
          params.require(:projects)
        end
      end
    end
  end
end
