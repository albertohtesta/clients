# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  describe "getting investments for a team" do
    let!(:team_one) { create(:team) }

    july = Time.new(2022, 7, 15, 1, 1, 1).to_date
    august = Time.new(2022, 8, 15, 1, 1, 1).to_date
    september = Time.new(2022, 9, 15, 1, 1, 1).to_date

    before do
      travel_to september
      create(:investment, team: team_one, value: 10, date: july)
      create(:investment, team: team_one, value: 23, date: august)
      create(:investment, team: team_one, value: 123, date: september)
    end

    it "expects records for the previous month" do
      investments = described_class.investments_by_team_for_period team_one.id, :months
      expect(investments.count).to eq 1
      expect(investments[0].value).to eq 23
      expect(investments[0].date).to eq august
    end

    it "expects records for the current quarter" do
      travel_to september
      investments = described_class.investments_by_team_for_period team_one.id, :quarters
      expect(investments.count).to eq 3
      expect(investments[0].value).to eq 10
    end
  end
end
