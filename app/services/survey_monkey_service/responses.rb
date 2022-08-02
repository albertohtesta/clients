# frozen_string_literal: true

module SurveyMonkeyService
  # API endpoints thatReturns list of survey responses for survey
  class SurveyResponses
    def responses(survey_id, options = {})
      Client.new.get("/v3/surveys/#{survey_id}/responses", query: options)
    end

    # Returns response's information for survey
    def response(survey_id, response_id, options = {})
      Client.new.get("/v3/surveys/#{survey_id}/responses/#{response_id}", query: options)
    end

    # Returns response's information for survey with details
    def response_with_details(survey_id, response_id, options = {})
      Client.new.get("/v3/surveys/#{survey_id}/responses/#{response_id}/details", query: options)
    end
  end
end
