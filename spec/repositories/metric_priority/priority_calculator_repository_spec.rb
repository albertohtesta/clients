# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricPriority::PriorityCalculatorRepository, type: :repository do
  describe "Account metrics follow-ups" do
    context "when account has follow ups" do
      let(:date) { 2.weeks.ago }
      let!(:account) { create(:account) }
      let!(:account_follow_up) { create(:account_follow_up, follow_date: 2.months.ago, account:) }

      let!(:account_metric_balance) { create(:metric, related: account, indicator_type: "balance", date:) }
      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }

      let!(:account_metric_morale) { create(:metric, indicator_type: "morale", related: account, date:) }
      let!(:metric_limit_morale) { create(:metric_limit, indicator_type: "morale") }

      let!(:account_metric_performance) { create(:metric, indicator_type: "performance", related: account, date:) }
      let!(:metric_limit_performance) {
        create(:metric_limit, indicator_type: "performance", high_priority_max: 24)
      }

      it "should alert low because priority out of ranges" do
        performance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "performance")
          .priority
        expect(performance_priority[:amount]).to eq(75)
        expect(performance_priority[:alert]).to eq(false)
        expect(performance_priority[:attended_after_metric]).to eq(false)
        expect(performance_priority[:data_follow_up]["id"]).to eq(account_metric_performance.id)
        expect(performance_priority[:data_follow_up]["account_id"]).to eq(account.id)
        expect(performance_priority[:data_follow_up]["metric_type"]).to eq("performance")
      end

      it "should return true because priority matches high limits" do
        balance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "balance")
          .priority
        expect(balance_priority[:amount]).to eq(75)
        expect(balance_priority[:alert]).to eq(true)
      end

      it "should have default" do
        default_priority = MetricPriority::PriorityCalculatorRepository.new(account, "unverified").priority
        expect(default_priority[:amount]).to eq(0)
        expect(default_priority[:attended_after_metric]).to eq(false)
        expect(default_priority[:alert]).to be false
        expect(default_priority[:data_follow_up]["metric_type"]).to eq("unverified")
      end
    end
  end
end
