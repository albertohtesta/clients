# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      before_action :access_token, :decode_token, :verify_token, :current_user

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        # loggin from rollbar
        Rollbar.warning("Data from token ========>")
        Rollbar.error(@data_token, @data_token.class)
        Rollbar.warning("Data from token END========>")

        render json: { message: "Invalid token" }, status: :unauthorized unless @data_token
      end

      def current_user
        Rollbar.warning(@data_token, "==current user function==")
        if @data_token[0]["role"] == "client"
          contact = ContactService.new({ token: access_token })
          @current_user ||= ContactRepository.find_by({ email: contact.logged_contact_email })
        elsif @data_token[0]["role"] == "collaborator"
          collaborator = CollaboratorService.new({ token: access_token })
          @current_user ||= CollaboratorRepository.find_by({ email: collaborator.logged_user_email })
        end
      end

      def decode_token
        @data_token = TokenService.new({ token: @access_token }).decode
        Rollbar.error(@data_token, "Token decodificado")
      end
    end
  end
end
