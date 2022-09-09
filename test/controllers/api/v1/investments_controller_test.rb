# frozen_string_literal: true

require "test_helper"

class Api::V1::Teams::InvestmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
    @team = create(:team)
    @investment = create(:investment, { team: @team })
    @month = Time.now.month
    @quarter =
      case @month
      when 1, 2, 3 then "q1"
      when 4, 5, 6 then "q2"
      when 7, 8, 9 then "q3"
      when 10, 11, 12 then "q4"
      end
  end

  test "should get success response" do
    get api_v1_team_investments_organized_path(@investment.team.id, "months"), headers: { "Authorization" => @token }
    assert_response :success
  end

  test "should get investments from previous month" do
    get api_v1_team_investments_organized_path(@investment.team.id, "months"), headers: { "Authorization" => @token }
    assert_equal response.parsed_body["project_indicators"].first["label"], (Date.today - 1.month).strftime("%B")
  end

  test "should get investments for current quarter" do
    get api_v1_team_investments_organized_path(@investment.team.id, "quarters"), headers: { "Authorization" => @token }
    assert_equal response.parsed_body["project_indicators"].first["label"], @quarter
  end

  test "should get 'Team not found' error" do
    get api_v1_team_investments_organized_path(0, "quarters"), headers: { "Authorization" => @token }
    assert_response :not_found
  end
end
