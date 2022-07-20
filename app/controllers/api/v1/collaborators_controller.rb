# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApplicationController
      before_action :set_project, only: :index

      def index
        return render json: { message: "No collaborators", status: "404" } if @collaborators.empty?

        render json: CollaboratorPresenter.json_collection(@collaborators), status: :ok
      end

      private
        def set_project
          @collaborators = CollaboratorRepository.find_collaborators_by_project_id(params[:project_id])
        end
    end
  end
end
