# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyJob, type: :job do
  describe "#perform_later" do
    let!(:team) { create(:team) }
    let!(:survey) { create(:survey, team:) }

    it "enqueue job that closes survey" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SurveyJob.perform_later survey
      }.to have_enqueued_job
    end

    it "enqueue job for the correct date" do
      ActiveJob::Base.queue_adapter = :test
      expect { SurveyJob.set(wait_until: survey.deadline.to_time, queue: "low")
               .perform_later(survey) }.to have_enqueued_job.with(survey)
               .on_queue("low").at(survey.deadline.to_time)
    end

    it "closes the survey" do
      ActiveJob::Base.queue_adapter = :test
      SurveyJob.perform_now(survey)
      expect(survey.reload.status).to eq("closed")
    end
  end
end
