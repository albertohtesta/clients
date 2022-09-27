# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamBalancePresenter do
  let(:team_balance) { build(:team_balance) }
  let(:presenter) { described_class.new(team_balance) }

  describe "#index" do
    it "renders the team balances as json" do
      expected_keys = %w[balance balance_date team_id account_id]

      expect(presenter.json.keys).to eql(expected_keys)
    end
  end
end
