# frozen_string_literal: true

require "test_helper"

class Api::V1::Teams::InvestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
    @team = create(:team)
    @investment = create(:investment, { team: @team })
  end

  test "should get success response" do
    get api_v1_team_investments_organized_path(@investment.team.id, "months"), headers: { "Authorization" => @token }
    assert_response :success
  end

  test "should get investments by months" do
    get api_v1_team_investments_organized_path(@investment.team.id, "months"), headers: { "Authorization" => @token }
    assert_equal response.parsed_body["project_indicators"].first["label"], "January"
  end

  test "should get investments by quarters" do
    get api_v1_team_investments_organized_path(@investment.team.id, "quarters"), headers: { "Authorization" => @token }
    assert_equal response.parsed_body["project_indicators"].first["label"], "q1"
  end

  test "should get 'Team not found' error" do
    get api_v1_team_investments_organized_path(0, "quarters"), headers: { "Authorization" => @token }
    assert_response :not_found
  end
end
