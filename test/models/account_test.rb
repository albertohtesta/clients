require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "can create account" do
    assert build_stubbed(:account)
    assert build_stubbed(:account).valid?
  end

  test "account is invalid without account_uuid and name" do
    refute Account.new(name: "HCP").valid?
    refute Account.new(account_uuid: "123xxx").valid?
  end
end
