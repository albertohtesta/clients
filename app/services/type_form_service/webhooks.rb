# frozen_string_literal: true

module TypeFormService
  # API endpoints for typeform webhooks
  class Webhooks
    # Lists all existing webhooks of a single survey
    def all(form_id, options = {})
      Client.new.get("forms/#{form_id}/webhooks", query: options)
    end

    # shows a single webhook of a single survey
    def find(form_id, tag, options = {})
      Client.new.get("forms/#{form_id}/webhooks/#{tag}", query: options)
    end

    # creates a webhook or updates an existing one
    def update!(form_id, tag, options = {})
      Client.new.put("forms/#{form_id}/webhooks/#{tag}", query: options)
    end

    # deletes a webhook
    def delete(form_id, tag, options = {})
      Client.new.delete("forms/#{form_id}/webhooks/#{tag}", query: options)
    end
  end
end
