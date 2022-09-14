# frozen_string_literal: true

class SurveyJob < ApplicationJob
  queue_as :default

  def perform(survey)
    SurveyResponsesService.new(survey.id).close_survey unless survey.status == "closed"
  end
end
