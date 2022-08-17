# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey, type: :model do
  describe "model validations" do
    it "can't create survey when team_id doesn't exist" do
      @survey = build_stubbed(:survey, team_id: 100)
      expect(@survey).not_to be_valid
    end

    it "can't create survey when missing field" do
      @survey = build_stubbed(:survey, deadline: nil)
      expect(@survey).not_to be_valid
    end

    it "can't create survey when dateline is wrong" do
      @survey = build_stubbed(:survey, deadline: "2022-01-01")
      expect(@survey).not_to be_valid
    end

    it "can't create survey when another survey is open" do
      @survey = build_stubbed(:survey, team_id: 1)
      @survey_two = build_stubbed(:survey, team_id: 1)
      expect(@survey_two).not_to be_valid
    end

    it "can create survey" do
      @survey = build_stubbed(:survey)
      expect(@survey).to be_valid
    end
  end
end
