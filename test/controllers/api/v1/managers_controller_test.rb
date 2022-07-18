# frozen_string_literal: true

require "test_helper"

class ManagersControllerTest < ActionDispatch::IntegrationTest
  test "should get success response" do
    @collaborator = create(:collaborator)
    get api_v1_manager_path(@collaborator.id)
    assert_response :success
  end

  test "should get 'Manager not found' error" do
    get api_v1_manager_path(1)
    assert_response :not_found
  end
end
