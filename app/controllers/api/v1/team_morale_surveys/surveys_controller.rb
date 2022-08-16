# frozen_string_literal: true

module Api
  module V1
    module TeamMoraleSurveys
      # surveys controller
      class SurveysController < ApiController
        def create
          @survey = Survey.new(survey_params.merge(status: "preparation"))
          if @survey.save
            render json: SurveyPresenter.new(@survey).json, status: :ok
          else
            render json: { errors: @survey.errors.full_messages }, status: :bad_request
          end
        end

        private
          def survey_params
            params.require(:survey).permit(:team_id, :deadline, :period)
          end
      end
    end
  end
end
