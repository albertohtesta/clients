# frozen_string_literal: true

require "test_helper"

class AppAuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credentials = { api_name: "api_26d680024c3374525178568bc7db51e2", secret_token: "secret_VAvIwWA__1uppDBR2aBxnA" }
    @invalid_credentials = { api_name: "api_26d680024c343256178568bc7db51e2",
                             secret_token: "secret_VAvoprt451uppDBR2aBxnA" }
    AppConnection.create({ name: "API test", api_name: "api_26d680024c3374525178568bc7db51e2",
                           secret_token: "secret_VAvIwWA__1uppDBR2aBxnA" })
  end

  test "should get success status" do
    post "/api/v1/app_auth", params: @credentials
    assert_response :success
  end

  test "should get authenticate and return token" do
    post "/api/v1/app_auth", params: @credentials

    response_body = JSON.parse(response.body, symbolize_names: true)
    assert response_body[:token]
  end

  test "should get unauthorized code" do
    post "/api/v1/app_auth", params: @invalid_credentials
    assert_response :unauthorized
  end
end
