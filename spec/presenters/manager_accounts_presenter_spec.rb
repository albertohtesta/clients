# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManagerAccountsPresenter, type: :presenter do
  describe "Manager Accounts Presenter validation" do
    let!(:account) { create(:account) }
    let!(:presenter) { described_class.new(account) }

    context "on a clean account" do
      it "must return formated json" do
        expected_keys = [
          "id",
          "account_uuid",
          "name",
          "minilogo",
          "location",
          "collaborators_number",
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

      it "expects values for a newly created account" do
        expect(presenter.last_follow_up_text).to eq("No follow ups found")
        expect(presenter.alert).to be "medium"
      end
    end

    context "with follow ups" do
      let!(:account_follow_up) { create(:account_follow_up, follow_date: 7.days.ago.to_date, account:) }

      it "expects to display last follow up from account" do
        expect(presenter.last_follow_up_text).to eq("7 days ago")
        expect(presenter.alert).to be "low"
      end
    end

    context "with metric follow ups" do
      let!(:account_metric) { create(:metric, related: account, indicator_type: "morale") }
      let!(:metric_limit) { create(:metric_limit, indicator_type: "morale") }
      let!(:metric_follow_up) { create(:metric_follow_up, follow_date: 5.days.ago, account:) }
      let!(:account_follow_up) { create(:account_follow_up, follow_date: 2.month.ago.to_date, account:) }

      it "expects to retrieve latest follow up date" do
        expect(presenter.last_follow_up_text).to eq("5 days ago")
      end

      it "expects to ignore metric alert if attended recently" do
        expect(presenter.alert).to eq("low")
        expect(presenter.morale[:alert]).to eq("high")
        expect(presenter.morale[:attended_after_metric]).to eq(true)
      end
    end
  end
end
