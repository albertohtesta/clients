# frozen_string_literal: true

require "test_helper"

class Api::V1::CollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    params = { project_id: 1 }
    get api_v1_project_collaborators_path(params)
    assert_equal response.parsed_body, { "message" => "No collaborators", "status" => "404" }
  end
end
