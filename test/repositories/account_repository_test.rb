# frozen_string_literal: true

require "test_helper"

class AccountRepositoryTest < ActiveSupport::TestCase
  setup do
    create(:account_status, { status: "New", status_code: "new_project" })
    file = File.read Rails.root.join("test", "files", "test_salesforce.json")
    @account = JSON.parse(file, symbolize_names: true)
    @imported = AccountRepository.import(@account)
  end

  test "Import accounts correctly" do
    assert @imported
  end

  test "should get imported account name" do
    assert Account.find_by_name(@account[:account][:Name])
  end

  test "should get imported project name" do
    assert Project.find_by_name(@account[:opportunity][:Name])
  end

  test "should get imported contact FirstName" do
    assert Contact.find_by_first_name(@account[:contacts][0][:FirstName])
  end
end
