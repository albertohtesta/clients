# frozen_string_literal: true

module TypeFormService
  # API endpoints for surveys resources
  class Surveys
    def all(options = {})
      Client.new.get("forms", query: options)
    end

    # Returns surveys' information with details
    def find_with_details(form_id, options = {})
      Client.new.get("forms/#{form_id}", query: options)
    end
  end
end
