# frozen_string_literal: true

require_relative "application"
require_relative "initializers/rollbar"

notify = -> (e) do
  begin
    # To see more info about rollbar visit:
    # https://hixonrails.com/ruby-on-rails-tutorials/ruby-on-rails-rollbar-logger-installation-and-configuration/
    Rollbar.with_config(use_async: false) do
      Rollbar.error(e)
    end
  rescue
    Rails.logger.error "Synchronous Rollbar notification failed.  Sending async to preserve info"
    Rollbar.error(e)
  end
end

begin
  Rails.application.initialize!
rescue Exception => e
  notify.call(e)
  raise
end
