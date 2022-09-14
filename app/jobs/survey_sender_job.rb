class SurveySenderJob < ApplicationJob
  queue_as :default

  def perform(survey)
    survey.team.collaborators.each do |collaborator|
      SurveyMailer.with(
        collaborator_name: "#{collaborator.first_name} #{collaborator.last_name}", 
        collaborator_email: collaborator.email,
        subject: survey.description, 
        survey_url: survey.survey_url
      ).survey_created.deliver_later
    end
  end
end
