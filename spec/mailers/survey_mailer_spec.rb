# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyMailer, type: :mailer do
  describe "survey_created" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:) }

    let(:mail) { SurveyMailer.with(collaborator: survey.team.collaborators.first, subject: survey.description, survey_url: survey.survey_url).survey_created }

    it "renders the headers" do
      expect(mail.subject).to eq(survey.description)
      expect(mail.to).to eq(["MyString"])
      expect(mail.from).to eq(["Info@nordhen.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).not_to be_empty
    end
  end
end
