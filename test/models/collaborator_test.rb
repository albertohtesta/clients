# frozen_string_literal: true

require "test_helper"

class CollaboratorTest < ActiveSupport::TestCase
  test "can create colaborator" do
    assert build_stubbed(:collaborator)
    assert build_stubbed(:collaborator).valid?
  end

  test "is invalid without name email uuid" do
    assert_not Collaborator.new(email: "exmaple@gmail.com", uuid: "123").valid?
    assert_not Collaborator.new(name: "Jonh Doe", uuid: "123").valid?
    assert_not Collaborator.new(name: "Jonh Doe", email: "exmaple@gmail.com").valid?
  end
end
