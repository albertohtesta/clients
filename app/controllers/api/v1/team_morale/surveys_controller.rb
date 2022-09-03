# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        before_action :survey_by_id, only: :show

        def create
          @survey = Survey.new(survey_params.merge(status: "preparation", started_at:
                               SurveyResponsesService.calculate_started_at(params[:period], params[:period_value], params[:year])))
          if @survey.save
            render json: SurveyPresenter.new(@survey).json, status: :ok
          else
            render json: { errors: @survey.errors.full_messages }, status: :bad_request
          end
        end

        def index
          @surveys = TypeFormService::Surveys.new
          render json: @surveys.all
        end

        def show
          render json: SurveyPresenter.new(@survey).json, status: :ok
        end

        private
          def survey_params
            params.require(:survey).permit(:team_id, :deadline, :period, :survey_url, :year, :period_value, :description)
          end

          def survey_by_id
            @survey = SurveyRepository.find(params[:id])
          end
      end
    end
  end
end
