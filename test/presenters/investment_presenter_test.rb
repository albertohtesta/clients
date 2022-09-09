# frozen_string_literal: true

require "test_helper"

class InvestmentPresenterTest < ActiveSupport::TestCase
  setup do
    travel_to Time.new(2022, 9, 15, 1, 1, 1)
  end

  def investment_current
    @investment_current = build(:investment, { date: Time.now.to_date, value: 4500 })
  end

  def investment_previous
    @investment_previous = build(:investment, { date: (Time.now - 1.month).to_date, value: 2300 })
  end

  def investments
    [investment_previous, investment_current]
  end

  test "it should get last month" do
    response = InvestmentPresenter.order_by_months(investments)
    assert_equal response.length, 1
    assert_equal response.last["label"], "August"
    assert_equal response.last["value"], @investment_previous.value
  end

  test "it should sum current quarter" do
    response = InvestmentPresenter.order_by_quarters(investments)
    assert_equal response.length, 1
    assert_equal response.last["label"], "q3"
    assert_equal response.last["value"], (@investment_current.value + @investment_previous.value)
  end
end
