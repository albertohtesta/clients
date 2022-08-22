# frozen_string_literal: true

require "rails_helper"

RSpec.describe CollaboratorRepository do
  describe "repository validation" do
    # TODO: This list of id's is just temporally, will be replaced
    collaborator_ids = [1, 2, 3, 4, 5, 6, 7, 200, 201, 202, 203]
    collaborator_ids.map do |id|
      let!(:"collaborator#{id}") { create(:collaborator, id:) }
    end

    it "must return talent pool directory" do
      pool_directory = described_class.collaborators_pool_directory

      expect(pool_directory.first).to be_an_instance_of Collaborator
      expect(pool_directory).not_to be_empty
      expect(pool_directory.length).to equal(collaborator_ids.length)
      expect(pool_directory.last["nickname"]).to eq("MyString")
    end
  end
end
