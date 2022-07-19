# frozen_string_literal: true

require "test_helper"

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  test "When the count have contacts" do
    @account = create(:account)
    @contact = create(:contact, account: @account)
    get api_v1_manager_account_contacts_path(account_id: @account.id, manager_id: @account.manager_id)
    assert_response :ok
  end

  test "When the count doesnt have contacts" do
    get api_v1_manager_account_contacts_path(account_id: 1, manager_id: 1)
    assert_equal response.parsed_body, { "message" => "Contacts not found", "status" => "404" }
  end
end
