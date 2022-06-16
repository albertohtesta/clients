# frozen_string_literal: true

require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "can create team" do
    assert build_stubbed(:team)
    assert build_stubbed(:team).valid?
  end

  test "is invalid without added_date" do
    refute Team.new.valid?
  end

  test "belongs to team type" do
    assert_not_nil build_stubbed(:team).team_type
  end
end
