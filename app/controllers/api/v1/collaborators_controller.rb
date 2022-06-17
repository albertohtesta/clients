# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApplicationController
      before_action :retrieve_collaborator

      def accounts
        file      = File.read(Rails.root.join("public", "assets", "collaborator_1_account.json"))
        @accounts = JSON.parse(file)

        render json: @accounts, status: :ok
      end

      private

      def retrieve_collaborator
        # TODO: uncomment code to get collaborator @collaborator = Collaborator.find(params[:id])
      end
    end
  end
end
