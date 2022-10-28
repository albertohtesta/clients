# frozen_string_literal: true

class SurveysStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform
    puts ">>Updating status of Surveys .....<<"
    SurveyResponsesService.surveys_status_update
  end
end
