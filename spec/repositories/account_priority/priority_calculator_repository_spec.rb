# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountPriority::PriorityCalculatorRepository do
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
      let!(:metric_limit_gross_marging) { create(:metric_limit, indicator_type: "gross_marging") }

      it "should return true" do
        high_priority = AccountPriority::PriorityCalculatorRepository
          .new(account, account_follow_up["follow_date"])
          .high_priority

        expect(high_priority).to be true
      end
    end

    context "when the metric is medium" do
      let(:date) { 2.weeks.ago }
      let!(:account) { create(:account) }
      let!(:account_follow_up) { create(:account_follow_up, follow_date: 2.months.ago, account:) }

      let!(:account_metric_balance) { create(:metric, related: account, indicator_type: "balance", date:, value: 85) }
      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }

      let!(:account_metric_morale) { create(:metric, indicator_type: "morale", related: account, date:, value: 85) }
      let!(:metric_limit_morale) { create(:metric_limit, indicator_type: "morale") }

      let!(:account_metric_performance) { create(:metric, indicator_type: "performance", related: account, date:, value: 85) }
      let!(:metric_limit_performance) { create(:metric_limit, indicator_type: "performance") }

      let!(:account_metric_gross_marging) {
        create(:metric, indicator_type: "gross_marging", related: account, date:, value: 85)
      }
      let!(:metric_limit_gross_marging) { create(:metric_limit, indicator_type: "gross_marging") }

      it "should return true" do
        high_priority = AccountPriority::PriorityCalculatorRepository
          .new(account, account_follow_up["follow_date"])
          .medium_priority

        expect(high_priority).to be true
      end
    end
  end
end
