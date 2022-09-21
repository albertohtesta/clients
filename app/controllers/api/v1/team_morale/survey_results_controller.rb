# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveyResultsController < ApplicationController
        before_action :validate_required_params, :validate_period, :validate_processing_type, only: %i[ index ]

        def index
          render json: survey_results, status: :ok
        end

        private
          def survey_results
            SurveyResultsService.survey_results(survey_results_params[:period], survey_results_params[:year],
              survey_results_params[:team_id], survey_results_params[:processing_type])
          end

          def validate_period
            render json: { message: "Period invalid must be [0..2]" }, status: :bad_request unless params[:period].to_i.between?(0, 2)
          end

          def validate_processing_type
            render json: { message: "Procession type invalid must be Q or A" }, status: :bad_request unless params[:processing_type] == "A" || params[:processing_type] == "Q"
          end

          def validate_required_params
            params.require([:period, :year, :team_id, :processing_type])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end

          def survey_results_params
            params.permit(:team_id, :year, :period, :processing_type)
          end
      end
    end
  end
end
