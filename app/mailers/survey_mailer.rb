# frozen_string_literal: true

class SurveyMailer < ApplicationMailer
  def survey_created
    @collaborator = params[:collaborator]
    @subject = params[:subject]
    @survey_url = params[:survey_url]

    mail(
      to: @collaborator.email,
      subject: @subject
    )
  end
end
