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
        @collaborator = Collaborator.find params[:id]
      end
    end
  end
end
