# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamMetricsService do
  describe "team metrics service functionality" do
    subject(:team) { create(:team) }

    it "must create metrics" do
      metrics_from_api = { "January": { "estimatedPoints": 82, "completedPoints": 68, "performance": 81 } }
      described_class.load_team_metrics(team.id, metrics_from_api)

      expect(Metric.count).to eql(2)
    end
  end
end
