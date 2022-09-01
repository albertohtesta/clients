# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollaboratorRepository do
  describe "collaborator validation" do
    subject(:collaborator) { create(:collaborator) }

    it "must return collaborator public profile" do
      public_collaborator = described_class.find_collaborator_public_profile(collaborator.id)

      expect(public_collaborator).to eq(Collaborator.first)
    end

    it "must not return collaborator public profile" do
      public_collaborator = described_class.find_collaborator_public_profile(0)

      expect(public_collaborator).to be_nil
    end
  end

  describe "talent pool repository validation" do
    let!(:account) { create(:account) }
    collaborator_ids = [1, 3, 4, 5, 6, 7, 8, 9, 200, 201, 202, 203]
    collaborator_ids.map do |id|
      let!(:"collaborator#{id}") { create(:collaborator, id:) }
      let!(:"accounts_collaborator#{id}") { create(:accounts_collaborator, collaborator_id: id, account_id: Account.first.id) }
    end

    it "must return talent pool directory" do
      pool_directory = described_class.collaborators_pool_directory(Account.first.id, "")

      expect(pool_directory).not_to be_empty
      expect(pool_directory.first).to be_an_instance_of Collaborator
    end
  end
end
