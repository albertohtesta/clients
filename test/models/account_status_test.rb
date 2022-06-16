# frozen_string_literal: true

require "test_helper"

class AccountStatusTest < ActiveSupport::TestCase
  test "can create account status" do
    assert build_stubbed(:account_status)
    assert build_stubbed(:account_status).valid?
  end
end
