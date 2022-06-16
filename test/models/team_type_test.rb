require "test_helper"

class TeamTypeTest < ActiveSupport::TestCase
  test "can create account team type" do
    assert build_stubbed(:team_type)
    assert build_stubbed(:team_type).valid?
  end
end
