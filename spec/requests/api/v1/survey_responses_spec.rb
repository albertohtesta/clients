# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Survey responses service" do
  describe "close survey" do
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

  describe "Average of a survey" do
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

    it "returns the average of the last survey of a team" do
      expect(SurveyResponsesService.average_of_last_survey_of_team(1)).to eq(75)
    end

    it "returns nil when there are no questions in the survey" do
      @survey.questions_detail = nil
      @survey.save
      expect(SurveyResponsesService.average_of_last_survey_of_team(1)).to be_nil
    end
  end
end
