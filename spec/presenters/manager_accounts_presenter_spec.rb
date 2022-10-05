# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManagerAccountsPresenter, type: :presenter do
  describe "presenter validation" do
    let(:account) { create(:account) }
    let(:presenter) { described_class.new(account) }
    let!(:metric_follow_up) { create(:metric_follow_up, account:) }

    it "must return formated json" do
      expected_keys = [
        "id",
        "account_uuid",
        "name",
        "minilogo",
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
      expect(presenter.priority).to be "medium"
      expect(presenter.alert).to be "medium"
    end

    it "expects metric to read by category" do
      expect(metric_follow_up.metric_type).to eq METRICS_TYPES[:morale]
    end
  end
end
