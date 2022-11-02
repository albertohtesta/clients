# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyRepository do
  describe "repository validation" do
    let(:collaborator) { create(:collaborator) }
    let(:team) { create(:team) }
    let(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:, status: :preparation) }
    let!(:closed_survey) { create(:survey, team:, status: :closed) }

    it "must return survey given id" do
      selected_survey = described_class.find_by_id(survey.id)

      expect(selected_survey).to eql(survey)
    end

    # TODO: Alberto
    # it "must return survey per team date status" do
    #   selected_survey = described_class.surveys_by_team_dates_status(survey.id)

    #   expect(selected_survey.id).to eql(survey.id)
    # end

    it "must return team's last survey" do
      selected_survey = described_class.last_closed_survey_of_team(team.id)

      expect(selected_survey).to eql(closed_survey)
    end

    it "must mark survey as sent" do
      selected_survey = described_class.mark_survey_as_sent(survey.id)

      expect(selected_survey.status).to eql("sent")
      expect(selected_survey.requested_answers).to eql(survey.team.collaborators.size)
    end

    it "must update survey's current asnwers" do
      selected_survey = described_class.update_current_answers(survey.id, 2)

      expect(selected_survey.current_answers).to eql(2)
    end
  end
end
