# frozen_string_literal: true

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "can create project" do
    assert build_stubbed(:project)
    assert build_stubbed(:project).valid?
  end

  test "is invalid without name start_date" do
    assert_not build(:project, name: nil).valid?
    assert_not build(:project, start_date: nil).valid?
  end

  test "belongs to account" do
    assert_not_nil build_stubbed(:project).account
  end
end
