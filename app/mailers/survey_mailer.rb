# frozen_string_literal: true

class SurveyMailer < ApplicationMailer
  def survey_created
    @collaborator_name = params[:collaborator_name]
    @collaborator_email = params[:collaborator_email]
    @subject = params[:subject]
    @survey_url = params[:survey_url]

    mail(
      to: @collaborator_email,
      subject: @subject
    )
  end
end
