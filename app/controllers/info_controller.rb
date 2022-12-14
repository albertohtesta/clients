# frozen_string_literal: true

# endpoint to response with json body to set deployed commit info
class InfoController < ApplicationController
  # TODO: temporalily disable the requirement of access token, enable when login be ready
  # skip_before_action :verify_token

  def build_info
    file = File.read(Rails.root.join("build-info.json"))
    @info_response = JSON.parse(file)

    render json: @info_response, status: :ok
  end
end
