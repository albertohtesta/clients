# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentRepository do
  context "on investment existing for a team" do
    let!(:team) { create(:team) }
    let!(:investment) { create(:investment, team:, date: Date.today) }

    it "must return accounts per manager" do
      start_date = (Time.now - 30.days).to_date
      monthly_investments = described_class.retrieve_monthly_investments_by_team(team.id, start_date)
      expect(monthly_investments).to be_a ActiveRecord::Relation
      expect(monthly_investments.to_a.size).to eq 1
      expect(monthly_investments.first["team_id"]).to eq team.id
      expect(monthly_investments.first["value"]).to eq investment.value
      expect(monthly_investments.first["date"].month).to eq investment.date.month
    end
  end
end
