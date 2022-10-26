# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentPresenter, type: :presenter do
  include ActiveSupport::Testing::TimeHelpers

  before do
    travel_to Time.new(2022, 9, 15, 1, 1, 1)
  end

  describe "setting up json for investment records" do
    let!(:team) { create(:team) }
    let!(:september_investment) { build(:investment, { date: Time.now.to_date, value: 4500, team_id: team.id }) }
    let!(:august_investment) { build(:investment, { date: (Time.now - 1.month).to_date, value: 2300, team_id: team.id }) }

    it "expects data by month" do
      investments = [august_investment, september_investment]
      response = described_class.order_by_monthly(investments)
      expect(response[:project_indicators].length).to eq 9
      expect(response[:project_indicators].first["label"]).to eq "August"
      expect(response[:project_indicators].first["value"]).to eq august_investment.value
      expect(response[:project_indicators].first["value"]).to be_a Float
      expect(response[:project_indicators].first["value"]).to eq 2300.0
    end

    it "expects investment sum for current quarter" do
      investments = [august_investment, september_investment]
      response = described_class.order_by_quarter(investments)
      expect(response[:project_indicators].length).to eq 3
      expect(response[:project_indicators].last["label"]).to eq "Q3"
      expect(response[:project_indicators].last["value"]).to eq (september_investment.value + august_investment.value)
      expect(response[:project_indicators].last["value"]).to be_a Float
      expect(response[:project_indicators].last["value"]).to eq 6800.0
    end
  end
end
