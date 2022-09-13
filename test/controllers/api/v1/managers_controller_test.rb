# frozen_string_literal: true

require "test_helper"

class ManagersControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "should get success response" do
    collaborator = create(:collaborator, :manager)
    get api_v1_manager_path(collaborator.id), headers: { "Authorization" => @token }
    assert_response :success
  end

  test "should get 'Manager not found' error" do
    get api_v1_manager_path(0), headers: { "Authorization" => @token }
    assert_response :not_found
  end
end
