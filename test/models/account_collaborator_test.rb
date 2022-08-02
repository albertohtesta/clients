# frozen_string_literal: true

require "test_helper"

class AccountCollaboratorTest < ActiveSupport::TestCase
  test "should be valid" do
    assert build(:account_collaborator)
  end

  test "should not be valid" do
    assert_not build(:account_collaborator, account: nil).valid?
  end
end
