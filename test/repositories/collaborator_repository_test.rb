# frozen_string_literal: true

require "test_helper"

class CollaboratorRepositoryTest < ActiveSupport::TestCase
  setup do
    @collaborator = create(:collaborator)
  end

  test "get collaborator public profile" do
    assert CollaboratorRepository.find_collaborator_public_profile(@collaborator.id)
  end

  test "return nil when collaborator not present" do
    assert_nil CollaboratorRepository.find_collaborator_public_profile(0)
  end

  test "gets talent pool directory" do
    assert CollaboratorRepository.collaborators_pool_directory
  end
end
