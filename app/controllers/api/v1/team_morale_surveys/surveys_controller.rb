# frozen_string_literal: true

module Api
  module V1
    module TeamMoraleSurveys
      # surveys distribution controller
      class SurveysController < ApiController
        def create
          @team = Team.find_by_id(params[:team_id])
          render json: { errors: "Team doesn't exist." }, status: :bad_request and return unless @team.present?
          collaborators = CollaboratorRepository.find_collaborators_by_project_id(params[:team_id])
          @survey = Survey.new(survey_params.merge(status: "preparation"))
          if self.open_survey? && @survey.save && collaborators.any?
            render json:
            {
              data: {
                team_id: params[:team_id],
                total_team_members: collaborators.count,
                dateline: Date.parse(params[:deadline])
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

          def open_survey?
            unless @team.surveys.last.closed?
              @errors = "Hay un survey abierto"
              false
            else
              true
            end
          end
      end
    end
  end
end
