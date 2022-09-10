# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class SurveysController < ApplicationController
        before_action :survey_by_id, only: %i[show destroy]

        def create
          @survey = Survey.new(get_survey_params_data)
          if @survey.save
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
          if SurveyResponsesService.close_survey(@survey.id)
            render json: { message: "Survey has been closed"}, status: :ok
          else
            render json: { error: "survey could not be closed" }, status: :bad_request
          end
        end

        private
          def survey_params
            params.require(:survey).permit(:team_id, :deadline, :period, :survey_url, :year, :period_value, :description)
          end

          def survey_by_id
            @survey = SurveyRepository.find(params[:id])
          end

          def get_survey_params_data
            survey_remote_data = get_survey_remote_data(params[:description], params[:survey_url])
            get_survey_params(survey_remote_data)
          end

          def get_survey_remote_data(description, survey_url)
            SurveyCreateService.get_survey_remote_data(description, survey_url)
          end

          def get_survey_params(survey_remote_data)
            local_data = survey_params.merge(status: "preparation", started_at:
            SurveyCreateService.calculate_started_at(params[:period], params[:period_value], params[:year]))
            return local_data unless survey_remote_data.present?

            local_data.merge(survey_url: survey_remote_data[:survey_url], remote_survey_id: survey_remote_data[:remote_survey_id])
          end
      end
    end
  end
end
