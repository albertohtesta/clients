# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveySenderJob, type: :job do
  describe "#perform_later" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }
    let!(:survey) { create(:survey, team:) }

    it "Sends email" do
      expect do
        SurveySenderJob.perform_now survey.id
      end.to change { ActionMailer::Base.deliveries.count }.by(team.collaborators.count)
    end
  end
end
