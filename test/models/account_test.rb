# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "can create account" do
    assert build_stubbed(:account)
    assert build_stubbed(:account).valid?
  end

  test "account is invalid without account_uuid and name" do
    assert_not build(:account, name: nil, account_uuid: "xxxxx").valid?
  end

  test "Import accounts correctly" do
    create(:account_status, { status: "New", status_code: "new_project" })
    file = File.read Rails.root.join("test", "files", "test_salesforce.json")
    accounts = JSON.parse(file, symbolize_names: true)
    imported = Account.import(accounts)
    assert imported
  end
end
