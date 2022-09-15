# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "close survey" do
  let(:survey) { create(:survey, id: 1, survey_url: "www.ficticia.com") }

  it "returns the survey when closing it" do
    response = SurveyResponsesService.new(survey.id).close_survey
    expect(response).to be_truthy
  end

  it "closes the survey" do
    expect { SurveyResponsesService.new(survey.id).close_survey }
    .to change { survey.reload.status }.from("preparation").to("closed")
  end

  it "do not close survey that is incomplete" do
    @survey = create(:survey, id: 1, survey_url: "www.ficticia.com", current_answers: 0, requested_answers: 5)
    SurveyResponsesService.new(@survey.id).close_survey
    expect(@survey.reload.status).not_to eq("closed")
  end

  it "close survey after its deadline" do
    @survey = create(:survey, id: 1, survey_url: "www.ficticia.com", current_answers: 2, requested_answers: 5)
    @survey.update_columns(deadline: Date.today - 1)
    SurveyResponsesService.new(@survey.id).close_survey
    expect(@survey.reload.status).to eq("closed")
  end

  it "returns false if survey not exist" do
    response = SurveyResponsesService.new(5000).close_survey
    expect(response).to be_falsey
  end
end
