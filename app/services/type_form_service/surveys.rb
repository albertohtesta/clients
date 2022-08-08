# frozen_string_literal: true

module TypeFormService
  # API endpoints for surveys
  class Surveys
    # Returns a list of every survey
    def all(options = {})
      Client.new.get("forms", query: options)
    end

    # Returns a given survey's information
    def find(form_id, options = {})
      Client.new.get("forms/#{form_id}", query: options)
    end

    # Returns a given survey's url
    def url(form_id, options = {})
      find(form_id, options)[:_links][:display]
    end
  end
end
