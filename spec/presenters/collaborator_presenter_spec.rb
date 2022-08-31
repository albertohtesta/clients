# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollaboratorPresenter do
  describe "" do
    let!(:collaborator) { create(:collaborator) }
    let!(:team) { create(:team) }
    let!(:collaborator_team) { create(:collaborators_team, collaborator:, team:) }

    it "must return formated json" do
      expected_keys = %w[id uuid position name posts_count img post]
      presenter_result = described_class.json_collection(Collaborator.all)

      expect(presenter_result.first.keys).to eq(expected_keys)
    end
  end
end
