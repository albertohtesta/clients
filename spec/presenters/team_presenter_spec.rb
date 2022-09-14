# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeamPresenter do
  describe "Team presenter" do
    let!(:team) { create(:team) }

    it "must return formated json" do
      expected_keys = %w[id added_date team_type_id project_id board_id]
      presenter_result = described_class.json_collection(Team.all)

      expect(presenter_result.first.keys).to eq(expected_keys)
    end
  end
end
