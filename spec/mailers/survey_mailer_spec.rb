# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyMailer, type: :mailer do
  describe "survey_created" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:) }

    let(:mail) do
      collaborator = survey.team.collaborators.first
      collaborator_presenter = CollaboratorPresenter.new(collaborator)
      SurveyMailer.with(
        collaborator_name: collaborator_presenter.json["name"],
        collaborator_email: collaborator.email,
        subject: survey.description,
        survey_url: survey.survey_url
      ).survey_created
    end

    it "renders the mail" do
      expect(mail.subject).to eq(survey.description)
      expect(mail.to).to eq([collaborator.email])
      expect(mail.from).to eq(["Info@nordhen.com"])
      expect(mail.html_part.body.to_s).to match(survey.survey_url)
    end
  end
end
