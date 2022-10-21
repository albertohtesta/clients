# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveysStatusUpdateJob, type: :job do
  it "enqueue job that update surveys status" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      SurveysStatusUpdateJob.perform_later
    }.to have_enqueued_job
  end
end
