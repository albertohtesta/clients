# frozen_string_literal: true

module TypeFormService
  # API endpoints thatReturns list of survey responses for survey
  class Responses
    # Returns response's information for survey
    def all(form_id, options = {})
      Client.new.get("forms/#{form_id}/responses", query: options)
    end

    def insights(form_id, options = {})
      Client.new.get("insights/#{form_id}/summary", query: options)
    end
  end
end
