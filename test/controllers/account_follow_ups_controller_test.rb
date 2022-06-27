# frozen_string_literal: true

require "test_helper"

class AccountFollowUpsControllerTest < ActionDispatch::IntegrationTest
  test "should get all follow ups" do
    get api_v1_collaborator_account_account_follow_ups_path(collaborator_id: 1, account_id: 1)
    assert_response :ok
  end

  test "should create a new register" do
    create(:account, id: 1)

    post api_v1_collaborator_account_account_follow_ups_path(collaborator_id: 1, account_id: 1), params:
      {
        account_follow_ups: {
          follow_date: Date.today,
          account_id: 1
        }
      }

    assert_response :created
  end
end
