# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManagerAccountsPresenter, type: :presenter do
  describe "presenter validation" do
    let!(:account) { create(:account) }
    let!(:presenter) { described_class.new(account) }
    let!(:metric_follow_up) { create(:metric_follow_up, account:) }

    it "must return formated json" do
      expected_keys = [
        "id",
        "account_uuid",
        "name",
        "location",
        "last_follow_up_text",
        "priority",
        "role_debt",
        "alert",
        "team_balance",
        "performance",
        "morale",
        "velocity",
        "manager_id"
      ]

      expect(presenter.json.keys).to eql(expected_keys)
    end

    it "expects to read priority status" do
      expect(presenter.last_follow_up).to be_nil
      expect(presenter.priority).to_not eq "low"
    end

    it "expects metric to read by category" do
      expect(metric_follow_up.metric_type).to eq METRICS_TYPES[:morale]
    end

    it "expects metric alert to be false when no metrics" do
      expect(presenter.alert).to be false
    end
  end
end
