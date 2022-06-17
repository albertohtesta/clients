# frozen_string_literal: true

module Api
  module  V1
    class CollaboratorsController < ApplicationController
      before_action :retrieve_collaborator

      def show
        file = File.read(Rails.root.join("public", "assets", "collaborator_1_account.json"))
        @accounts = JSON.parse(file)

        render json: @accounts, status: :ok
      end

      private

      def retrieve_collaborator; end
    end
  end
end
