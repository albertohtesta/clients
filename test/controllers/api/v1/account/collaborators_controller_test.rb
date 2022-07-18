# frozen_string_literal: true

require "test_helper"

class Api::V1::Account::CollaboratorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    params = { id: 1 }
    get api_v1_account_collaborator_path(params)
    assert_equal response.parsed_body, { "message" => "No collaborators", "status" => "404" }
  end
end
