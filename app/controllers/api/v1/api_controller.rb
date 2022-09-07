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
        if decoded_token[0]["cognito:groups"]&.include?("admin")
          contact = ContactService.new({ token: access_token })
          @current_user ||= ContactRepository.find_by({ uuid: contact.logged_contact_email })
        elsif decoded_token[0]["cognito:groups"]&.include?("collaborator")
          collaborator = CollaboratorService.new({ token: access_token })
          @current_user ||= CollaboratorRepository.find_by({ email: collaborator.logged_user_email })
        end
      end

      def decoded_token
        @data_token ||= TokenService.new({ token: access_token }).decode
      end
    end
  end
end
