# frozen_string_literal: true

require "rails_helper"

RSpec.describe ManagerAccountsPresenter do
  describe "presenter validation" do
    let!(:account) { build(:account) }
    let!(:presenter) { described_class.new(account) }

    it "must return formated json" do
      expected_keys = [
        "id",
        "account_uuid",
        "name",
        "location",
        "collaborators_number",
        "last_follow_up_text",
        "priority",
        "role_debt",
        "alert",
        "team_balance",
        "client_management",
        "performance",
        "gross_margin",
        "morale",
        "velocity",
        "manager_id"
      ]

      expect(presenter.json.keys).to eql(expected_keys)
    end
  end
end
