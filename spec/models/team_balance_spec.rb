# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamBalance, type: :model do
  describe "validations" do
    it { should validate_presence_of(:balance) }
    it { should validate_presence_of(:blance_date) }
    it { should validate_presence_of(:team_id) }
    it { should validate_presence_of(:account_id) }
  end

  describe "associations" do
    it { should belong_to(:team) }
    it { should belong_to(:account) }
  end
end
