# frozen_string_literal: true

module Api
  module V1
    module Account
      class CollaboratorsController < ApplicationController
        before_action :set_collaborators, only: :show

        def show
          return render json: { message: "No collaborators", status: "404" } if @collaborators.empty?

          render json: CollaboratorPresenter.json_collection(@collaborators), status: :ok
        end

        private
          def set_collaborators
            @collaborators = CollaboratorRepository.find_collaborator_and_post(params[:id])
          end
      end
    end
  end
end
