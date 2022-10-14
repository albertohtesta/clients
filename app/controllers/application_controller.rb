# frozen_string_literal: true

class ApplicationController < ActionController::API
  # TODO: temporalily disable the requirement of access token, enable when login be ready
  # before_action :access_token, :verify_token

  def access_token
    @access_token ||= request.headers["Authorization"]
  end

  def verify_token
    decoded_token
    render json: { message: "Invalid token" }, status: :unauthorized unless @data_token
  end

  private
    def decoded_token
      @data_token = TokenService.new({ token: access_token }).decode
    end
end
