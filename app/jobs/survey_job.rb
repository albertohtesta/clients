# frozen_string_literal: true

class SurveyJob < ApplicationJob
  queue_as :default

  def perform(survey)
    SurveyResponsesService.close_survey(survey.id) unless survey.status == 2
  end
end
