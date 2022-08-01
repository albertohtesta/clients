# frozen_string_literal: true

module Api
  module V1
    # api v1 controller
    class ApiController < ApplicationController
      # TODO: enable the following before_actions when the login logic is ready to use
      # before_action :access_token, :verify_token, :current_user

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        render json: { message: "Invalid token" }, status: :unauthorized unless decoded_token
      end

      def decoded_token
        @decoded_token ||= TokenService.new({ token: access_token }).decode
      end

      def current_user
        Collaborator.first
        # TODO: the following lines of code should return the currently logged user in cognito. Enable when login is ready.
        # collaborator = CollaboratorService.new({ token: access_token })
        # @current_user ||= CollaboratorRepository.find_by_email(collaborator.logged_user_email)
      end
    end
  end
end
