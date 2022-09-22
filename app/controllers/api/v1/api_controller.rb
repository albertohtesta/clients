# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      before_action :access_token, :verify_token, :current_user

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        render json: { message: "Invalid token" }, status: :unauthorized unless decoded_token
      end

      def current_user
        user_service = UserService.new({ token: access_token })
        if decoded_token[0]["cognito:groups"]&.include?("client")
          @current_user ||= ContactRepository.find_by({ email: user_service.logged_user_email, uuid: decoded_token[0]["sub"] })
        elsif decoded_token[0]["cognito:groups"]&.include?("collaborator")
          @current_user ||= CollaboratorRepository.find_by({ email: user_service.logged_user_email, uuid: decoded_token[0]["sub"] })
        elsif decoded_token[0]["cognito:groups"]&.include?("admin")
          @current_user ||= CollaboratorRepository.find_by({ email: user_service.logged_user_email, uuid: decoded_token[0]["sub"] })
        end
      end

      def decoded_token
        @data_token ||= TokenService.new({ token: access_token }).decode
      end
    end
  end
end
