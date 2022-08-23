# frozen_string_literal: true

require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "can't create survey when missing field" do
    @survey = build_stubbed(:survey, deadline: nil)
    assert_not @survey.valid?
  end

  test "can't create survey when team_id doesn't exist" do
    @survey = build_stubbed(:survey, team_id: 100)
    assert_not @survey.valid?
  end

  test "can't create survey when dateline is wrong" do
    @survey = build_stubbed(:survey, deadline: "2022-01-01")
    assert_not @survey.valid?
  end

  test "can't create survey when another survey is open" do
    @survey = build_stubbed(:survey, team_id: 1)
    @survey_two = build_stubbed(:survey, team_id: 1)
    assert_not @survey_two.valid?
  end

  test "can create survey" do
    @survey = build_stubbed(:survey)
    assert @survey.valid?
  end
end
