# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Managers::AccountsController, type: :controller do
  describe "#index" do
    context "when a metric account is low priority" do
      let!(:date) { 2.weeks.ago }
      let!(:account) { create(:account, city: "city") }
      let(:account_follow_up) { create(:account_follow_up, account:, follow_date: date) }

      let!(:account_metric_balance) { create(:metric, related: account, date:, indicator_type: "balance", value: 95) }
      let!(:account_metric_morale) { create(:metric, related: account, date:, indicator_type: "morale", value: 95) }
      let!(:account_metric_performance) { create(:metric, related: account, date:, indicator_type: "performance", value: 95) }
      let!(:account_metric_gross_marging) { create(:metric, related: account, date:, indicator_type: "gross_marging", value: 95) }

      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }
      let!(:metric_limit_morale) { create(:metric_limit, indicator_type: "morale") }
      let!(:metric_limit_performance) { create(:metric_limit, indicator_type: "performance") }
      let!(:metric_limit_gross_marging) { create(:metric_limit, indicator_type: "gross_marging") }

      it "must return priority eql low" do
        expected_keys = [
          { "id" => account.id,
            "name" => "MyString",
            "location" => "city",
            "last_follow_up_text" => "No follow ups found",
            "priority" => "low",
            "role_debt" => 0,
            "alert" => true,
            "team_balance" => { "amount" => 85, "alert" => true },
            "client_management" => { "amount" => 85, "alert" => true },
            "performance" => { "amount" => 85, "alert" => true },
            "gross_margin" => { "amount" => 85, "alert" => true },
            "morale" => { "amount" => 85, "alert" => true }
          }
        ]

        get :index, params: { manager_id: account.manager_id }
        expect(JSON.parse(response.body)).to eql(expected_keys)
      end
    end
  end
end
