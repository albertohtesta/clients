# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricLimit, type: :model do
  describe "model validations" do
    subject { build(:metric_limit) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end
