# frozen_string_literal: true

require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "can create survey" do
    assert build_stubbed(:survey)
    assert build_stubbed(:survey).valid?
  end
end
