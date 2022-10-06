# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricPriority::PriorityCalculatorRepository, type: :repository do
  describe "Account metrics response" do
    let!(:account) { create(:account) }

    context "when account has metrics" do
      let(:date) { 2.weeks.ago }

      let!(:account_metric_balance) { create(:metric, related: account, indicator_type: "balance", date:) }
      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }

      let!(:morale1) { create(:metric, indicator_type: "morale", value: 90, related: account, date:) }
      let!(:morale2) { create(:metric, indicator_type: "morale", value: 96, related: account, date: date.end_of_month) }
      let!(:metric_limit_morale) { create(:metric_limit, indicator_type: "morale") }

      let!(:metric_performance) { create(:metric, indicator_type: "performance", related: account, value: 30) }
      let!(:metric_limit_performance) { create(:metric_limit, indicator_type: "performance",
        high_priority_max: 24, medium_priority_min: 25) }

      it "should consider multiple value for average amount" do
        priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "morale")
          .priority
        expect(priority[:amount]).to eq(93)
      end

      it "should be high alert if range is in medium but there is no follow up" do
        performance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "performance")
          .priority
        expect(performance_priority[:alert]).to eq("high")
      end

      it "should on medium alert with a recent follow up" do
        create(:metric_follow_up, follow_date: 7.days.ago, metric_type: "performance", account:)
        performance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "performance")
          .priority
        expect(performance_priority[:alert]).to eq("medium")
      end

      it "should return true because value matches high limits" do
        balance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "balance")
          .priority
        expect(balance_priority[:amount]).to eq(75)
        expect(balance_priority[:alert]).to eq("high")
      end
    end

    context "when account has no metrics and no follow ups" do
      it "should return blank values" do
        priority = MetricPriority::PriorityCalculatorRepository.new(account, "balance").priority
        expect(priority[:amount]).to eq(0)
        expect(priority[:attended_after_metric]).to eq(false)
        expect(priority[:alert]).to eq("low")
        expect(priority[:data_follow_up]["id"]).to eq(nil)
        expect(priority[:data_follow_up]["account_id"]).to eq(account.id)
        expect(priority[:data_follow_up]["manager_id"]).to eq(account.manager_id)
        expect(priority[:data_follow_up]["metric_type"]).to eq("balance")
      end

      it "has no follow up dates" do
        expect(MetricPriority::PriorityCalculatorRepository.last_follow_up_date(account.id)).to be_nil
      end
    end

    context "when the metric is velocity" do
      let(:date) { 2.weeks.ago }
      let!(:account) { create(:account) }
      let!(:project) { create(:project, account:) }
      let!(:team) { create(:team, project:) }
      let!(:collaborator) { create(:collaborator, position: "SOFTWARE ENGINEER") }
      let!(:collaborators_team) { create(:collaborators_team, team:, collaborator:) }
      let!(:account_metric_velocity) { create(:metric, value: 11, related: account, indicator_type: "velocity", date:) }

      it "should return false because points are upper than collabs multiplied by ten" do
        priority = MetricPriority::PriorityCalculatorRepository.new(account, "velocity").priority

        expect(priority[:amount]).to eq(11)
        expect(priority[:alert]).to eq("low")
        expect(priority[:attended_after_metric]).to eq(false)
      end

      it "should return high because points are lower than collabs multiplied by ten" do
        account_metric_velocity.update(value: 1)
        priority = MetricPriority::PriorityCalculatorRepository.new(account, "velocity").priority

        expect(priority[:alert]).to eq("high")
        expect(priority[:attended_after_metric]).to eq(false)
      end
    end
  end
end
