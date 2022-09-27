# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        before_action :survey_by_id, only: %i[show destroy]

        def index
          @surveys = SurveyRepository.all
          render json: @surveys
        end

        def create
          @survey = Survey.new(local_and_remote_survey_params)
          if SurveyRepository.save(@survey)
            SurveyCreateService.create_job(@survey)
            render json: SurveyPresenter.new(@survey).json, status: :ok
          else
            render json: { errors: @survey.errors.full_messages }, status: :bad_request
          end
        end

        def show
          render json: SurveyPresenter.new(@survey).json, status: :ok
        end

        def destroy
          if SurveyResponsesService.new(@survey.id).close_survey
            render json: true, status: :ok
          else
            render json: false, status: :bad_request
          end
        end

        private
          def survey_params
            params.require(:survey).permit(:team_id, :deadline, :period, :survey_url, :year, :period_value, :description)
          end

          def survey_by_id
            @survey = SurveyRepository.find(params[:id])
          end

          def local_and_remote_survey_params
            survey_remote_data = SurveyCreateService.get_survey_remote_data(params[:description], params[:survey_url])
            local_data = survey_params.merge(status: "preparation", started_at:
            SurveyCreateService.calculate_started_at(params[:period], params[:period_value], params[:year]))
            return local_data unless survey_remote_data.present?

            local_data.merge(survey_url: survey_remote_data[:survey_url], remote_survey_id: survey_remote_data[:remote_survey_id])
          end
      end
    end
  end
end
