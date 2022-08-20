# frozen_string_literal: true

require "test_helper"

class Api::V1::Accounts::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "should not get index" do
    @account = create(:account)
    get api_v1_account_contacts_path(account_id: @account.id), headers: { "Authorization" => @token }
    assert_equal response.parsed_body, { "message" => "Contacts not found" }
  end
end
