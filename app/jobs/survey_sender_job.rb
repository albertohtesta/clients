# frozen_string_literal: true

class SurveySenderJob < ApplicationJob
  queue_as :default

  def perform(survey_id)
    survey = Survey.find(survey_id)
    survey.team.collaborators.find_each do |collaborator|
      SurveyMailer.with(
        collaborator_name: CollaboratorPresenter.new(collaborator).json["name"],
        collaborator_email: collaborator.email,
        subject: survey.description,
        survey_url: survey.survey_url
      ).survey_created.deliver_now
    end
    SurveyRepository.mark_survey_as_sent(survey.id)
  end
end
