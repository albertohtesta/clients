# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveySenderJob, type: :job do
  describe "#perform_later" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:) }

    it "Sends email" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SurveySenderJob.perform_later survey.id
      }.to have_enqueued_job
    end
  end
end
