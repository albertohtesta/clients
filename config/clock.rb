# frozen_string_literal: true

require "clockwork"
require "active_support/time"
require_relative "boot"
require_relative "environment"

module Clockwork
  # handler receives the time when job is prepared to run in the 2nd argument
  handler do |job, time|
    puts "Running #{job}, at #{time}"
  end

  # TODO: Change programation for every day
  every(1.hour, "Executing Job: ") { TeamsOudatedMetricsJob.perform_now }
end
