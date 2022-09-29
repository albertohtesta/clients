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

    it "raise error historial and mitigation_strategy" do
      alert_status = "not_exist"
      mitigation_strategy = "mitigation_strategy"
      expect { described_class.add_follow_up(id: metric_follow_up.id, alert_status:, mitigation_strategy:) }.to raise_error(ArgumentError)
    end
  end
end
