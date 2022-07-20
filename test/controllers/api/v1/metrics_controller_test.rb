# frozen_string_literal: true

require "test_helper"

class MetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
    @project = create(:project)
    create(:metric, project_id: @project.id)
  end

  test "should get team metrics" do
    get api_v1_metrics_path, headers: { "Authorization" => @token }, params: { from_date: "2022-01-11", to_date: "2022-05-11", project_id: @project.id, group_by: "monthly", indicator_type: "performance" }

    assert_response :success
  end
end
