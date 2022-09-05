# frozen_string_literal: true

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

notify = ->(e) do
  begin
    Rollbar.with_config(use_async: false) do
      Rollbar.error(e)
    end
  rescue
    Rails.logger.error "Synchronous Rollbar notification failed.  Sending async to preserve info"
    Rollbar.error(e)
  end
end
