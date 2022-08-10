# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveyResultsController < ApplicationController
        before_action :validate_required_params, :validate_period, only: %i[ index ]
        def index
          results = SurveyResultsService.get_surveys(params[:period], params[:year],
                    params[:team_id])
          render json: results, status: :ok
        end

        private
          def validate_period
            if !params[:period].to_i.between?(0, 2)
              render json: { message: "Period invalid" }, status: :bad_request
            end
          end

          def validate_required_params
            params.require([:period, :year, :team_id])
          rescue ActionController::ParameterMissing
            render json: { message: "Parameters missing" }, status: :bad_request
          end
      end
    end
  end
end
