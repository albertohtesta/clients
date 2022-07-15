# frozen_string_literal: true

require "test_helper"

class MetricTest < ActiveSupport::TestCase
  test "can create a metric" do
    assert build_stubbed(:metric)
  end
end
