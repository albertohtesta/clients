# frozen_string_literal: true

require "test_helper"

class Api::V1::Managers::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    stub_cognito_uri
    @account = create(:account)
  end

  test "should get index response" do
    get api_v1_manager_accounts_path(@account.manager_id), headers: { "Authorization" => @token }

    assert_response :success
  end
end
