# frozen_string_literal: true

module Api
  module V1
    class AppAuthController < JwtAuthAppsController
      def create
        @app = AppConnection.find_by_api_token(params[:api_token])
        if @app&.authenticate(params[:secret_token])
          token = JsonWebToken.jwt_encode({ app_id: @app.id })
          render json: { token: }, status: :ok
        else
          render json: { error: "Invalid Credentials" }, status: :unauthorized
        end
      end
    end
  end
end
