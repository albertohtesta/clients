# frozen_string_literal: true

require "test_helper"

class MetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
    @team = create(:team)
    create(:metric, related: @team)
  end

  test "should get team metrics by month" do
    get api_v1_metrics_path, params: { team_id: @team.id, group_by: "monthly", indicator_type: "performance" }, headers: { "Authorization" => @token }

    assert_response :success
  end

  test "should get team metrics by quarter" do
    get api_v1_metrics_path, params: { team_id: @team.id, group_by: "quarter", indicator_type: "performance" }, headers: { "Authorization" => @token }

    assert_response :success
  end

  test "should return 404 if not found metrics" do
    get api_v1_metrics_path, params: { team_id: 1, group_by: "monthly", indicator_type: "performance" }, headers: { "Authorization" => @token }

    assert_response :not_found
  end

  test "should return 400 if filter params not present" do
    get api_v1_metrics_path, params: { team_id: 1, indicator_type: "performance" }, headers: { "Authorization" => @token }

    assert_response :bad_request
  end
end
