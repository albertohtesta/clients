# frozen_string_literal: true

module TypeFormService
  # API endpoints for surveys
  class Surveys
    # Returns every survey
    def all(options = {})
      Client.new.get("forms", query: options)
    end

    # Returns surveys' information with details
    def find(form_id, options = {})
      Client.new.get("forms/#{form_id}", query: options)
    end

    # Returns surveys' information with details
    def url(form_id, options = {})
      find(form_id, options)[:_links][:display]
    end
  end
end
