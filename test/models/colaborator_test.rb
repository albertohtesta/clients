# frozen_string_literal: true

require "test_helper"

class ColaboratorTest < ActiveSupport::TestCase
  test "can create colaborator" do
    assert build_stubbed(:colaborator)
    assert build_stubbed(:colaborator).valid?
  end

  test "is invalid without name email uuid" do
    assert_not Colaborator.new(email: "exmaple@gmail.com", uuid: "123").valid?
    assert_not Colaborator.new(name: "Jonh Doe", uuid: "123").valid?
    assert_not Colaborator.new(name: "Jonh Doe", email: "exmaple@gmail.com").valid?
  end
end
