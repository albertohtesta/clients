# frozen_string_literal: true

module Api
  module V1
    module TeamMoraleSurveys
      # surveys distribution controller
      class DistributionsController < ApiController
        def create
          render json: { errors: "Team doesn't exist." }, status: :bad_request and return unless Team.where(:id => params[:team_id]).present?
          collaborators = CollaboratorRepository.find_collaborators_by_project_id(params[:team_id])
          if self.open_survey? && self.correct_info? && collaborators.any?
            render json: 
            { 
              data: {
                team_id: params[:team_id],
                total_team_members: collaborators.count
              } 
            }, status: :ok
          else
            render json: { errors: @error_msg }, status: :bad_request
          end
        end

        private
          def open_survey?
            team_surveys = Survey.where(:team_id => params[:team_id]).last
            @error_msg = 'There is a survey OPEN for this team.' and return false if team_surveys.status == 'open'
            return true
          end

          def correct_info?
            @error_msg = 'The dateline MUST be greater than today.' and return false unless Date.strptime(params[:deadline], '%d/%m/%y') > Date.today
            # @error_msg = 'The period ONLY CAN be monthly or quarter.' and return false if params[:period] > Date.today
            # @error_msg = 'The year MUST NOT be in the past.' and return false if Date.strptime(params[:year], '%y/%m/%d') > Date.today
            return true
          end
      end
    end
  end
end
