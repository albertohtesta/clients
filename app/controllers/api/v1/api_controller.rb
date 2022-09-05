# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      before_action :access_token, :verify_token, :current_user

      def access_token
        @access_token ||= request.headers["Authorization"]
      end

      def verify_token
        decoded_token
        Rollbar.log("Data from token ========>")
        Rollbar.log(@data_token) # loggin ffrom rollbar
        render json: { message: "Invalid token" }, status: :unauthorized unless @data_token
      end

      def current_user
        if @data_token[0]["role"] == "client"
          contact = @data_token[0]["user_attributes"].find { |x| x["name"] == "email" }["value"]
          @current_user ||= ContactRepository.find_by({ email: contact })
          # TODO: the following lines of code should return the currently logged CONTACT in cognito. Enable when login is ready.
          # contact = ContactService.new({ token: access_token })
          # @current_user ||= ContactRepository.find_by({email: contact.logged_contact_email})
        elsif @data_token[0]["role"] == "collaborator"
          Collaborator.first
          # TODO: the following lines of code should return the currently logged user in cognito. Enable when login is ready.
          # collaborator = CollaboratorService.new({ token: access_token })
          # @current_user ||= CollaboratorRepository.find_by_email(collaborator.logged_user_email)
        end
      end

      private
        def decoded_token
          @data_token ||= TokenService.new({ token: access_token }).decode
        end
    end
  end
end
