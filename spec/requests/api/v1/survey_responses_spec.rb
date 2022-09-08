# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "close survey" do
  before(:each) do
    @survey = create(:survey, id: 1, survey_url: "www.ficticia.com")
  end

  it "returns true if survey is closed" do
    response = SurveyResponsesService.close_survey(@survey.id)
    expect(response).to be_truthy
  end

  it "close survey and change status" do
    SurveyResponsesService.close_survey(@survey.id)
    expect(@survey.reload.status).to eq("closed")
  end

  it "do not close survey that is incomplete" do
    @survey.current_answers = 0
    @survey.requested_answers = 5
    @survey.save
    SurveyResponsesService.check_if_survey_should_be_closed(@survey.id)
    expect(@survey.reload.status).not_to eq("closed")
  end

  it "close survey after its deadline" do
    @survey.current_answers = 2
    @survey.requested_answers = 5
    @survey.deadline = Date.today - 1
    @survey.save
    SurveyResponsesService.check_if_survey_should_be_closed(@survey.id)
    expect(@survey.reload.status).to eq("closed")
  end

  it "returns false if survey not exist" do
    response = SurveyResponsesService.close_survey(5000)
    expect(response).to be_falsey
  end
end
