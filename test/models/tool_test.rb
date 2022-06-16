# frozen_string_literal: true

require "test_helper"

class ToolTest < ActiveSupport::TestCase
  test "can create tool" do
    assert build_stubbed(:tool)
    assert build_stubbed(:tool).valid?
  end
end
