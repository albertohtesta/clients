# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricPriority::PriorityCalculatorRepository do
  describe ".high_priority" do
    context "when the metric is high" do
      let(:date) { 2.weeks.ago }
      let!(:account) { create(:account) }
      let!(:account_follow_up) { create(:account_follow_up, follow_date: 2.months.ago, account:) }

      let!(:account_metric_balance) { create(:metric, related: account, indicator_type: "balance", date:) }
      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }

      let!(:account_metric_morale) { create(:metric, indicator_type: "morale", related: account, date:) }
      let!(:metric_limit_morale) { create(:metric_limit, indicator_type: "morale") }

      let!(:account_metric_performance) { create(:metric, indicator_type: "performance", related: account, date:) }
      let!(:metric_limit_performance) { create(:metric_limit, indicator_type: "performance") }

      let!(:account_metric_gross_marging) { create(:metric, indicator_type: "gross_marging", related: account, date:) }
      let!(:metric_limit_gross_marging) {
        create(:metric_limit, indicator_type: "gross_marging", high_priority_max: 24)
      }

      it "should return false because priority is high" do
        gross_marging_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "gross_margin")
          .priority

        expect(gross_marging_priority).to eq({ amount: 75, alert: false })
      end

      it "should return true because priority is low" do
        performance_priority = MetricPriority::PriorityCalculatorRepository
          .new(account, "performance")
          .priority

        expect(performance_priority).to eq({ amount: 75, alert: true })
      end
    end
  end
end
