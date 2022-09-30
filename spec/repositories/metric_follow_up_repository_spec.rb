# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricFollowUpRepository do
  describe "#update_historial" do
    let!(:manager) { create(:collaborator) }
    let!(:account) { create(:account, manager:) }
    let!(:metric_follow_up) { create(:metric_follow_up, account:) }

    it "update historial and mitigation_strategy" do
      alert_status = "in_progress"
      mitigation_strategy = "mitigation_strategy"

      update_metric = described_class.add_follow_up(id: metric_follow_up.id,
        alert_status:,
        mitigation_strategy:,
        manager_id: manager.id,
        account_id: account.id)
      expect { update_metric }.not_to raise_error
    end

    it "creates follow up with required id or metric_type" do
      update_metric = described_class.add_follow_up(metric_type: "balance",
        alert_status: "blocked",
        mitigation_strategy: "NA",
        account_id: account.id)
      expect { update_metric }.not_to raise_error
    end

    it "creates follow up with required accunt_id or manager_id" do
      update_metric = described_class.add_follow_up(metric_type: "balance",
        alert_status: "blocked",
        mitigation_strategy: "NA",
        manager_id: manager.id)
      expect { update_metric }.not_to raise_error
    end

    it "raise error on invalid status" do
      alert_status = "not_exist"
      mitigation_strategy = "mitigation_strategy"
      expect { described_class.add_follow_up(id: metric_follow_up.id, account_id: account.id, alert_status:, mitigation_strategy:) }.to raise_error(ArgumentError)
    end
  end
end
