# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountRepository do
  describe "repository validation" do
    subject(:account) { create(:account) }

    it "must return accounts per manager" do
      selected_accounts = described_class.by_manager(account.manager_id)

      expect(selected_accounts).to match_array([account])
    end

    it "must return account given id" do
      selected_account = described_class.account_project_by_account_id(account[:id])

      expect(selected_account.id).to eql(account.id)
    end
  end
end
