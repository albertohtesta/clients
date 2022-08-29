# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManagerAccountsPresenter do
  describe "presenter validation" do
    let!(:account) { build(:account) }
    let!(:presenter) { described_class.new(account) }

    it "must return formated json" do
      expected_keys = ["id", "name", "location", "last_follow_up_text", "priority", "role_debt", "alert", "team_balance", "client_management", "performance", "gross_margin", "morale"]

      expect(presenter.json.keys).to eq(expected_keys)
    end
  end
end
