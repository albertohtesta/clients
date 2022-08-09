# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountRepository do
  describe "repository validation" do
    subject(:account) { create(:account) }

    it "must return accounts per manager" do
      selected_accounts = described_class.by_manager(account.manager_id)

      expect(selected_accounts).to match_array([account])
    end
  end
end
