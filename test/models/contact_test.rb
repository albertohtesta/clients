# frozen_string_literal: true

require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "can create contact" do
    assert build_stubbed(:contact)
    assert build_stubbed(:contact).valid?
  end

  test "belongs to an account" do
    assert_not_nil build_stubbed(:contact).account
  end

  test "is invalid without email first_name" do
    assert_not build(:contact, first_name: nil).valid?
    assert_not build(:contact, email: nil).valid?
  end
end
