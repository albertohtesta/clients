# frozen_string_literal: true

require "test_helper"

class FollowHistoryTest < ActiveSupport::TestCase
  test "Should validate follow history" do
    assert build(:follow_history).valid?
    assert_not build(:follow_history, account_id: nil).valid?
    assert_not build(:follow_history, follow_date: nil).valid?
  end
end
