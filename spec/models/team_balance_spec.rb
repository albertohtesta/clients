# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamBalance, type: :model do
  subject { TeamBalance.new(balance: 98.5, balance_date: DateTime.now, team_id: 1, account_id: 1) }

  before { subject.save }

  it "should have a balance" do
    subject.balance = nil
    expect(subject).to_not be_valid
  end

  it "should have a date" do
    subject.balance_date = nil
    expect(subject).to_not be_valid
  end

  it "should have a team id" do
    subject.team_id = nil
    expect(subject).to_not be_valid
  end

  it "should have an account id" do
    subject.account_id = nil
    expect(subject).to_not be_valid
  end
end
