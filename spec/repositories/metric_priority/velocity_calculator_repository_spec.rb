# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricPriority::VelocityCalculatorRepository, type: :repository do
  describe "rate" do
    context "when the metric is velocity" do
      let!(:account) { create(:account) }
      let!(:project) { create(:project, account:) }
      let!(:team) { create(:team, project:) }
      let!(:collaborator) { create(:collaborator, position: "SOFTWARE ENGINEER") }
      let!(:collaborators_team) { create(:collaborators_team, team:, collaborator:) }
      let!(:account_metric_velocity) { create(:metric, value: 11, related: account, indicator_type: "velocity", date: 6.days.ago) }

      it "should be false because points are upper than collabs multiplied by ten" do
        priority = MetricPriority::VelocityCalculatorRepository.new(account).priority
        expect(priority[:alert]).to eq(ALERT[:low])
      end

      it "should be high because points are lower than collabs multiplied by ten" do
        account_metric_velocity.update(value: 1)
        priority = MetricPriority::VelocityCalculatorRepository.new(account).priority
        expect(priority[:alert]).to eq(ALERT[:high])
      end

      it "should be medium because points are betewwn 60 and 90 percent" do
        account_metric_velocity.update(value: 9)
        priority = MetricPriority::VelocityCalculatorRepository.new(account).priority
        expect(priority[:alert]).to eq(ALERT[:medium])
      end
    end
  end
end
