# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApplicationController
      before_action :retrieve_collaborator

      def show
        render json: CollaboratorPresenter.json(@collaborator)
      end

      private
        def retrieve_collaborator
          return if (@collaborator = Collaborator.includes(:accounts).find_by(id: params[:id]))

          render json: { error: "Collaborator not found" }, status: :not_found
        end
    end
  end
end
