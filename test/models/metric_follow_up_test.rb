# frozen_string_literal: true

require "test_helper"

class MetricFollowUpTest < ActiveSupport::TestCase
  test "can create a metric_follow_up" do
    assert build_stubbed(:metric_follow_up)
  end

  test "a metric can be related to manager or account" do
    assert build_stubbed(:metric_follow_up, manager_id: create(:collaborator).id, account_id: create(:account).id)
  end
end
