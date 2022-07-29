# frozen_string_literal: true

require "test_helper"

class Api::V1::CollaboratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "should get index" do
    params = { project_id: 1 }
    get api_v1_project_collaborators_path(params), headers: { "Authorization" => @token }
    assert_equal(response.parsed_body, { "message" => "No collaborators" })
    assert_response(:not_found)
  end
end