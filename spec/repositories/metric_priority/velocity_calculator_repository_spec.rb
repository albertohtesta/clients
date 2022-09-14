# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricPriority::VelocityCalculatorRepository, type: :repository do
  describe ".has_alert?" do
    context "when the metric is velocity" do
      let!(:account) { create(:account) }
      let!(:project) { create(:project, account:) }
      let!(:team) { create(:team, project:) }
      let!(:collaborator) { create(:collaborator, position: "SOFTWARE ENGINEER") }
      let!(:collaborators_team) { create(:collaborators_team, team:, collaborator:) }
      let!(:account_metric_velocity) { create(:metric, value: 11, related: account, indicator_type: "velocity", date: 2.weeks.ago) }

      it "should return false because points are upper than collabs multiplied by ten" do
        priority = MetricPriority::VelocityCalculatorRepository.new(account, account_metric_velocity.value, account_metric_velocity)

        expect(priority.has_alert?).to eq(false)
      end

      it "should return true because points are lower than collabs multiplied by ten" do
        account_metric_velocity.update(value: 1)
        priority = MetricPriority::VelocityCalculatorRepository.new(account, account_metric_velocity.value, account_metric_velocity)

        expect(priority.has_alert?).to eq(true)
      end

      it "should return true because points are betewwn 60 and 90 percent" do
        account_metric_velocity.update(value: 9)
        priority = MetricPriority::VelocityCalculatorRepository.new(account, account_metric_velocity.value, account_metric_velocity)

        expect(priority.has_alert?).to eq(true)
      end
    end
  end
end