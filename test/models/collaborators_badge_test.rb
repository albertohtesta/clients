# frozen_string_literal: true

require "test_helper"

class CollaboratorsBadgeTest < ActiveSupport::TestCase
  test "can create collaborator badge relation" do
    assert build_stubbed(:collaborators_badge)
  end
end
