# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  let!(:team) { create(:team) }

  july = Time.new(2022, 7, 15, 1, 1, 1).to_date
  august = Time.new(2022, 8, 15, 1, 1, 1).to_date
  september = Time.new(2022, 9, 15, 1, 1, 1).to_date
  past_december = Time.new(2021, 9, 15, 1, 1, 1).to_date

  before do
    travel_to september
    create(:investment, team:, value: 99, date: past_december)
    create(:investment, team:, value: 10, date: july)
    create(:investment, team:, value: 23, date: august)
    create(:investment, team:, value: 123, date: september)
  end

  describe "getting investments for a team" do
    it "expects monthly records for the team" do
      investments = described_class.investments_by_team_for_period team.id, :monthly
      expect(investments.size).to eq 2
      expect(investments[0].value).to eq 10
      expect(investments[0].date.month).to eq july.month
      expect(investments[1].value).to eq 23
      expect(investments[1].date.month).to eq august.month
    end

    it "expects current month for the quarterly report" do
      investments = described_class.investments_by_team_for_period team.id, :quarter
      expect(investments.size).to eq 3
      expect(investments[2].value).to eq 123
      expect(investments[2].date.month).to eq september.month
    end

    it "expects results for the requested year" do
      investments = described_class.investments_by_team_for_period team.id, :monthly, past_december.year
      expect(investments.size).to eq 1
      expect(investments[0].value).to eq 99
      expect(investments[0].date.month).to eq past_december.month
    end
  end

  describe "years for a team" do
    it "expects years from all investments" do
      years = described_class.years_for_a_team(team.id)
      expect(years).to contain_exactly(july.year, past_december.year)
    end
  end
end
