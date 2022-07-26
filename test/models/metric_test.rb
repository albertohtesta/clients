# frozen_string_literal: true

require "test_helper"

class MetricTest < ActiveSupport::TestCase
  test "can create a metric" do
    assert build_stubbed(:metric)
  end

  test "a metric can be related to team or account" do
    status = create(:account_status, { status_code: "myotherstatus" })
    assert build_stubbed(:metric, related: create(:team))
    assert build_stubbed(:metric, related: create(:account, { account_status: status }))
  end
end
