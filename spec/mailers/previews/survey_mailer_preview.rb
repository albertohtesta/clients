# frozen_string_literal: true

class SurveyMailerPreview < ActionMailer::Preview
  def survey_created
    SurveyMailer.with(
      collaborator_name: CollaboratorPresenter.new(Survey.last.team.collaborators.first).json["name"],
      collaborator_email: Survey.last.team.collaborators.first.email,
      subject: Survey.last.description,
      survey_url: Survey.last.survey_url
    ).survey_created
  end
end
