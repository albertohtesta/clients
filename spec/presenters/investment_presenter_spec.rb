# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentPresenter, type: :presenter do
  include ActiveSupport::Testing::TimeHelpers

  before do
    travel_to Time.new(2022, 9, 15, 1, 1, 1)
  end

  describe "setting up json for investment records" do
    let!(:september_investment) { build(:investment, { date: Time.now.to_date, value: 4500 }) }
    let!(:august_investment) { build(:investment, { date: (Time.now - 1.month).to_date, value: 2300 }) }

    it "expects data by month" do
      investments = [august_investment, september_investment]
      response = described_class.group_by_monthly(investments)
      expect(response[:project_indicators].length).to eq 9
      expect(response[:project_indicators].last["label"]).to eq "September"
      expect(response[:project_indicators].last["value"]).to eq september_investment.value
      expect(response[:project_indicators].last["value"]).to be_a Float
    end

    it "expects investment sum for current quarter" do
      investments = [august_investment, september_investment]
      response = described_class.group_by_quarter(investments)
      expect(response[:project_indicators].length).to eq 3
      expect(response[:project_indicators].last["label"]).to eq "Q3"
      expect(response[:project_indicators].last["value"]).to eq (september_investment.value + august_investment.value)
      expect(response[:project_indicators].last["value"]).to be_a Float
    end
  end
end
