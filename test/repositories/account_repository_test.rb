# frozen_string_literal: true

require "test_helper"

class AccountRepositoryTest < ActiveSupport::TestCase
  setup do
    create(:account_status, { status: "New", status_code: "new_project" })
    file = File.read Rails.root.join("test", "files", "test_salesforce.json")
    @accounts = JSON.parse(file, symbolize_names: true)
    @imported = AccountRepository.import(@accounts)
  end

  test "Import accounts correctly" do
    assert @imported
  end

  test "should get imported account name" do
    assert Account.find_by_name(@accounts[0][:account][:Name])
  end

  test "should get imported project name" do
    assert Project.find_by_name(@accounts[0][:opportunity][:Name])
  end

  test "should get imported contact FirstName" do
    assert Contact.find_by_first_name(@accounts[0][:contacts][0][:FirstName])
  end
end
