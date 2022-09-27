# frozen_string_literal: true

require "rails_helper"

RSpec.describe Team, type: :model do
  subject { Team.new(team_type_id: 3, project_id: 2, added_date: DateTime.now) }

  before { subject.save }

  it "should have a team type id" do
    subject.team_type_id = nil
    expect(subject).to_not be_valid
  end

  it "should have a project id" do
    subject.project_id = nil
    expect(subject).to_not be_valid
  end

  it "should have a date" do
    subject.added_date = nil
    expect(subject).to_not be_valid
  end
end
