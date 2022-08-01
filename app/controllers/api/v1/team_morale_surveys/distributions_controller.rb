# frozen_string_literal: true

module Api
  module V1
    module TeamMoraleSurveys
      # surveys distribution controller
      class DistributionsController < ApiController

        def create
          survey_monkey_response = true
          if survey_monkey_response
            render json: { data: "something truthy" }, status: :ok
          else
            render json: { errors: "something false" }, status: :bad_request
          end
        end

        private
          def distribution_params
          end
      end
    end
  end
end
