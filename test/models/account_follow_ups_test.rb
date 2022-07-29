# frozen_string_literal: true

require "test_helper"

class AccountFollowUpTest < ActiveSupport::TestCase
  test "Should validate follow up" do
    assert build(:account_follow_up).valid?
    assert_not build(:account_follow_up, account_id: nil).valid?
    assert_not build(:account_follow_up, follow_date: nil).valid?
  end
end
