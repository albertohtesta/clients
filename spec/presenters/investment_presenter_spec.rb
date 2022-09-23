# frozen_string_literal: true

require "rails_helper"

RSpec.describe InvestmentPresenter, type: :presenter do
  include ActiveSupport::Testing::TimeHelpers

  before do
    travel_to Time.new(2022, 9, 15, 1, 1, 1)
  end

  describe "setting up json for investment records" do
    let!(:investment_current) { build(:investment, { date: Time.now.to_date, value: 4500 }) }
    let!(:investment_previous) { build(:investment, { date: (Time.now - 1.month).to_date, value: 2300 }) }

    it "expects data for last month" do
      investments = [investment_previous, investment_current]
      response = described_class.order_by_monthly(investments)
      expect(response[:project_indicators]).not_to be_empty
      expect(response[:project_indicators].last["label"]).to eq "August"
      expect(response[:project_indicators].last["value"]).to eq investment_previous.value
    end

    it "expects investment sum for current quarter" do
      investments = [investment_previous, investment_current]
      response = described_class.order_by_quarter(investments)
      expect(response[:project_indicators].length).to eq 1
      expect(response[:project_indicators].last["label"]).to eq "Q3"
      expect(response[:project_indicators].last["value"]).to eq (investment_current.value + investment_previous.value)
    end
  end
end
