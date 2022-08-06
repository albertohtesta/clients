# frozen_string_literal: true

require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "can create survey" do
    assert build_stubbed(:survey)
    assert build_stubbed(:survey).valid?
  end
  test "can not create a survey without a team" do
    assert_not build_stubbed(:survey, team:nil).valid?
  end
  
  test "can get collaborators" do
    team = create(:team)
    collaborator = create(:collaborator)
    team.collaborators << collaborator
    survey = create(:survey, team: team)
    assert_equal(survey.team.collaborators.size, 1 )
  end
 
  test "can get collaborators email" do
    team = create(:team)
    collaborator = create(:collaborator)
    team.collaborators << collaborator
    survey = create(:survey, team: team)
    assert_not_nil(survey.team.collaborators.first.email)
  end
end
