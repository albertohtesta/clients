# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :access_token, :verify_token

  def access_token
    @access_token ||= request.headers["Authorization"]
  end

  def verify_token
    valid_token = TokenService.new({ token: access_token }).decode
    render json: { message: "Invalid token" }, status: :unauthorized unless valid_token
  end

  def current_user
    Collaborator.first
  end
end
