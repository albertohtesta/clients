# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "survey results" do
  before(:each) do
    morale_attribute_with_survey_questions
    create(:team, id: 1)
    @survey = create(:survey, team_id: 1, deadline: Date.today + 1.month, status: "closed",
        period: "month", period_value: Date.today.month, started_at: Date.today,
        year: Date.today.year, description: "TEST MONTHLY survey", survey_url: "www.fictional.com",
        questions_detail:
        { "questions": [{ "title": "question01", "category": "ORGULLO", "final_score": 100 },
                        { "title": "question02", "category": "ORGULLO", "final_score": 50 }]
        })
  end

  context "results by month by question " do
    let (:response) { SurveyResultsService.survey_results(0, @survey.year, @survey.team_id, "Q") }
    let(:current_month) {  Time.new.strftime("%B") }

    it "returns the month that haves surveys" do
      expect(response[current_month]).to be_truthy
    end

    it "returns the average by Question" do
      expect(response[current_month].last).to eq(75)
    end

    it "returns a hash of questions responses" do
      expect(response[current_month][0].class).to eq(Hash)
    end

    it "returns the score of a question" do
      expect(response[current_month][0][:final_score]).to eq(100)
    end
  end

  context "results by month by attribute " do
    let (:response) { SurveyResultsService.survey_results(0, @survey.year, @survey.team_id, "A") }
    let(:current_month) {  Time.new.strftime("%B") }

    it "returns the average by attribute" do
      expect(response[current_month].last).to eq(75)
    end

    it "returns the score of a attribute" do
      expect(response[current_month][0][:final_score]).to eq(75)
    end
  end

  it "returns the quarterly score" do
    response = SurveyResultsService.survey_results(1, @survey.year, @survey.team_id, "Q")
    expect(response.keys.last).to include("Q", "average")
    expect(response[response.keys.last]).to eq(75)
  end

  it "returns the yearly score" do
    response = SurveyResultsService.survey_results(2, @survey.year, @survey.team_id, "Q")
    expect(response[:year_average]).to eq(75)
  end

  it "returns empty hash if there are no surveys" do
    response = SurveyResultsService.survey_results(0, @survey.year + 1, @survey.team_id, "Q")
    expect(response).to eq({})
  end

  it "returns empty hash if the survey has no questions" do
    @survey.questions_detail = { "questions": nil }
    @survey.save
    response = SurveyResultsService.survey_results(2, @survey.year + 1, @survey.team_id, "Q")
    expect(response).to eq({})
  end
end
