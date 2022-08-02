# frozen_string_literal: true

module SurveyMonkeyService
  # API endpoints for surveys resources
  class Surveys
    def all(options = {})
      Client.new.get("/v3/surveys", query: options)
    end

    # Returns surveys' information with details
    def find_with_details(survey_id, options = {})
      Client.new.get("/v3/surveys/#{survey_id}/details", query: options)
    end
  end
end
