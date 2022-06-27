# frozen_string_literal: true

require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  test "can create payment" do
    assert build_stubbed(:payment)
    assert build_stubbed(:payment).valid?
  end

  test "is invalid without cut_off_date payday_limit" do
    assert_not build(:payment, cut_off_date: nil).valid?
    assert_not build(:payment, payday_limit: nil).valid?
  end

  test "belongs to account" do
    assert_not_nil build_stubbed(:payment).account
  end
end
