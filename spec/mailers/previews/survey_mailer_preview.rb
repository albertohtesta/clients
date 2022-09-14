# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/survey_mailer
class SurveyMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/survey_mailer/survey_created
  def survey_created
    SurveyMailer.with(
      collaborator_name: "#{Survey.last.team.collaborators.first.first_name} #{Survey.last.team.collaborators.first.last_name}",
      collaborator_email: Survey.last.team.collaborators.first.email, 
      subject: Survey.last.description, 
      survey_url: Survey.last.survey_url
    ).survey_created
  end
end
