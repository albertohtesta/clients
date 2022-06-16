# frozen_string_literal: true

require "test_helper"

class TechStackTest < ActiveSupport::TestCase
  test "can create tech stack" do
    assert build_stubbed(:tech_stack)
    assert build_stubbed(:tech_stack).valid?
  end
end
