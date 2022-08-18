# frozen_string_literal: true

class ApplicationController < ActionController::API
  # TODO: temporalily disable the requirement of access token, enable when login be ready
  # before_action :access_token, :verify_token

  def authenticate
    @access_token ||= request.headers[:Authorization]

    valid_token = TokenService.new({ token: access_token }).decode
    @account = AccountContactCollaboratorRepository.contacts_by_account(valid_token[0]["account_id"])

    render json: { message: "Invalid token" }, status: :unauthorized unless valid_token
  end

  private
    def current_user
      Collaborator.first
    end
end
