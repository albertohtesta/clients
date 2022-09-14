# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyMailer, type: :mailer do
  describe "survey_created" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:) }

    let(:mail) { SurveyMailer.with(
      collaborator_name: "#{survey.team.collaborators.first.first_name} #{survey.team.collaborators.first.last_name}",
      collaborator_email: survey.team.collaborators.first.email,
      subject: survey.description,
      survey_url: survey.survey_url
    ).survey_created }

    it "renders the mail" do
      expect(mail.subject).to eq(survey.description)
      expect(mail.to).to eq(["MyString"])
      expect(mail.from).to eq(["Info@nordhen.com"])
      expect(mail.html_part.body.to_s).not_to be_empty
      expect(mail.html_part.body.to_s).to have_link(survey.survey_url.to_s, href: survey.survey_url)
    end
  end
end
