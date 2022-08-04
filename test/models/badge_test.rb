# frozen_string_literal: true

require "test_helper"

class BadgeTest < ActiveSupport::TestCase
  test "can create badge" do
    assert build_stubbed(:badge)
  end

  test "badge is invalid without name" do
    assert_not build(:badge, name: nil).valid?
  end
end
