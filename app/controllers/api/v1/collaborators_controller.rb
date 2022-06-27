# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApplicationController
      before_action :retrieve_collaborator

      def show
        @collaborator.accounts
      end

      private

      def retrieve_collaborator
        return if (@collaborator = Collaborator.find_by(id: params[:id]))

        render json: { error: "Collaborator not found" }, status: :not_found
      end
    end
  end
end
