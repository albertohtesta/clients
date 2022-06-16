require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "can create project" do
    assert build_stubbed(:project)
    assert build_stubbed(:project).valid?
  end
  
  test "is invalid without name start_date" do
    refute Project.new(name: "2021-12-12").valid?
    refute Project.new(start_date: "2021-12-12").valid?
  end

  test "belongs to account" do
    assert_not_nil build_stubbed(:project).account
  end
end
