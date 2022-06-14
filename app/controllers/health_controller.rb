# frozen_string_literal: true

class HealthController < ActionController::API

  def status
    render json: {"build-id"=> "#BUILD_ID#", "build-date" => "#BUILD_DATE#", "build-branch" => "#BUILD_BRANCH#"}
  end

end
