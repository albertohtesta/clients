# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "can create posts" do
    assert build_stubbed(:post)
  end
end
