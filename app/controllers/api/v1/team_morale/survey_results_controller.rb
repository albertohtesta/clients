# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveyResultsController < ApplicationController
        before_action :validate_required_params, :validate_period, only: %i[ index ]

        def index
          render json: get_results, status: :ok
        end

        private

          def get_results
            SurveyResultsService.get_results(survey_results_params[:period], survey_results_params[:year],
              survey_results_params[:team_id])
          end

          def validate_period
              render json: { message: "Period invalid" }, status: :bad_request unless params[:period].to_i.between?(0, 2)
          end

          def validate_required_params
            params.require([:period, :year, :team_id])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end

          def survey_results_params
            params.require(:survey_result).permit(:team_id, :year, :period)
          end
      end
    end
  end
end
