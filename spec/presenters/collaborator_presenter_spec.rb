# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollaboratorPresenter do
  describe "presenter validation" do
    let(:collaborator) { build(:collaborator) }
    let(:presenter) { described_class.new(collaborator) }

    it "must return formated json" do
      expected_keys = %w[id uuid position name posts_count img post]
      expect(presenter.json.keys).to eq(expected_keys)
    end

    it "must return json without post" do
      expected_json_keys = %w[ id uuid position name posts_count img post ]

      expect(presenter.json.keys).to eq(expected_json_keys)
    end
  end
end
