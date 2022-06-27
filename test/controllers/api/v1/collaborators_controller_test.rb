# frozen_string_literal: true

require "test_helper"

class CollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "should get success response" do
    create(:collaborator, id: 1)
    get api_v1_collaborator_path(1)
    assert_response :success
  end

  test "should get 'Collaborator not found' error" do
    get api_v1_collaborator_path(1)
    assert_response :not_found
  end
end
