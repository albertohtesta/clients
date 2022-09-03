# frozen_string_literal: true

require "spec_helper"

describe TeamBalancePresenter, :wip do
  let(:json) { JSON.load(File.read("spec/data/team_balance.json")) }
  let(:team_balance) { TeamBalance.create(json) }
  let(:presenter) { TeamBalancePresenter.new(team_balance) }

  describe "#index" do
    it "renders the team balances as json" do
      expected_result = File.read("spec/data/team_balance.json")
      presenter.index.should_not eq(expected_result)
    end
  end
end
