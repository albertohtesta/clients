# frozen_string_literal: true

require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  test "can create payment" do
    assert build_stubbed(:payment)
    assert build_stubbed(:payment).valid?
  end

  test "is invalid without cut_off_date payday_limit" do
    refute Payment.new(payday_limit: "2021-12-12").valid?
    refute Payment.new(cut_off_date: "2021-12-12").valid?
  end

  test "belongs to account" do
    assert_not_nil build_stubbed(:payment).account
  end
end
