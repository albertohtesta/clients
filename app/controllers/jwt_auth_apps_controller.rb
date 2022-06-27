# frozen_string_literal: true

class JwtAuthAppsController < ActionController::API
  include JsonWebToken

  def authenticate_request
    header  = request.headers["Authorization"]
    header  = header.split.last if header
    decoded = JsonWebToken.jwt_decode(header)

    @current_app = AppConnection.find decoded[:app_id]
  end
end
