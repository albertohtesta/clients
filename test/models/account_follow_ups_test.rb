# frozen_string_literal: true

require "test_helper"

class AccountFollowUpsTest < ActiveSupport::TestCase
  test "Should validate follow up" do
    assert build(:account_follow_ups).valid?
    assert_not build(:account_follow_ups, account_id: nil).valid?
    assert_not build(:account_follow_ups, follow_date: nil).valid?
  end
end
