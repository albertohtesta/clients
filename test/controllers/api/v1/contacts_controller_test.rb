# frozen_string_literal: true

require "test_helper"

class Api::V1::ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
  end

  test "When the count have contacts" do
    @account = create(:account)
    @contact = create(:account_collaborator, account: @account)
    get api_v1_account_contacts_path(account_id: @account.id), headers: { "Authorization" => @token }
    assert_response :ok
  end

  test "When the count doesnt have contacts" do
    get api_v1_account_contacts_path(account_id: 1), headers: { "Authorization" => @token }
    assert_equal response.parsed_body, { "message" => "Contacts not found" }
  end
end
