# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "can create account" do
    assert build_stubbed(:account)
    assert build_stubbed(:account).valid?
  end

  test "account is invalid without account_uuid and name" do
    assert_not build(:account, name: "hcp", account_uuid: nil).valid?
    assert_not build(:account, name: nil, account_uuid: "xxxxx").valid?
  end
end
