# frozen_string_literal: true

module TypeFormService
  # API endpoints thatReturns list of survey responses for survey
  class SurveyResponses
    # Returns response's information for survey
    def responses(form_id, options = {})
      Client.new.get("forms/#{form_id}/responses", query: options)
    end
  end
end
