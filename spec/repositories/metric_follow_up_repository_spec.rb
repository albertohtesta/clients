# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricFollowUpRepository, type: :repository do
  describe "#add_follow_up" do
    let!(:manager) { create(:collaborator) }
    let!(:account) { create(:account, manager:) }
    let!(:metric) { create(:metric, related: account) }
    let!(:metric_follow_up) { create(:metric_follow_up,
      manager_id: manager.id, account_id: account.id, metric_type: metric.indicator_type, follow_date: Date.today) }
    let(:alert_status) { "in_progress" }
    let(:mitigation_strategy) { "mitigation_strategy" }

    context "on an update" do
      it "finds the key attributes from metric id reference" do
        updated_account = described_class.add_follow_up(id: metric.id,
          alert_status:,
          mitigation_strategy:)
        expect(updated_account).to be_a MetricFollowUp
      end

      it "sets status and mitigation_strategy" do
        described_class.add_follow_up(id: metric.id,
          alert_status:,
          mitigation_strategy:,
          manager_id: manager.id,
          account_id: account.id)
        updated_follow_up = MetricFollowUp.last
        expect(updated_follow_up.alert_status).to eq(alert_status)
        expect(updated_follow_up.mitigation_strategy).to eq(mitigation_strategy)
      end
    end

    context "on a creation" do
      it "creates follow up with required id or metric_type" do
        follow_up = described_class.add_follow_up(metric_type: "balance",
          alert_status: "blocked",
          mitigation_strategy: "NA",
          account_id: account.id)
        expect(follow_up).to be_a MetricFollowUp
        last = MetricFollowUp.last
        expect(follow_up).to eq(last)
        expect(follow_up.id).to_not eq(metric_follow_up.id)
      end

      it "creates follow up with required accunt_id or manager_id" do
        created = described_class.add_follow_up(metric_type: "balance",
          alert_status: "blocked",
          mitigation_strategy: "NA",
          manager_id: manager.id,
          account_id: account.id)
        follow_up = MetricFollowUp.last
        expect(created.id).to eq(follow_up.id)
        expect(created.id).to_not eq(metric_follow_up.id)
      end
    end

    context "on invalid input" do
      it "raises an Error on invalid status" do
        alert_status = "not_exist"
        mitigation_strategy = "mitigation_strategy"
        expect {
          described_class.add_follow_up(id: metric_follow_up.id, account_id: account.id, alert_status:, mitigation_strategy:)
        }.to raise_error(ArgumentError)
      end

      it "raises with invalid reference" do
        mitigation_strategy = "mitigation_strategy"
        expect {
          described_class.add_follow_up(account_id: account.id, alert_status: "in_progress", mitigation_strategy:)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
