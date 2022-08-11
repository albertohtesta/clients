# frozen_string_literal: true

module Api
  module V1
    module TeamMoraleSurveys
      # surveys controller
      class SurveysController < ApiController
        def create
          @survey = Survey.new(survey_params.merge(status: "preparation"))
          if @survey.save
            render json:
            {
              survey: {
                team_id: @survey.team_id,
                survey_id: @survey.id,
                total_team_members: @survey.team.collaborators.count
              }
            }, status: :ok
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
