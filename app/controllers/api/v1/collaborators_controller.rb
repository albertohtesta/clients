# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApiController
      before_action :collaborators_by_project, only: :index

      def index
        return render json: { message: "No collaborators" }, status: :not_found if @collaborators.empty?

        render json: CollaboratorPresenter.json_collection(@collaborators), status: :ok
      end

      private
        def collaborators_by_project
          @collaborators = CollaboratorRepository.find_collaborators_by_project_id(params[:team_id])
        end
    end
  end
end
