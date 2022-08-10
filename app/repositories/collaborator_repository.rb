# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  class << self
    def find_collaborators_by_team_id(team_id)
      scope.includes(:posts, :teams).where(teams: { id: team_id })
    end

    def by_role_name(name)
      scope.includes(:role).where(role: RoleRepository.find_by(name:))
    end

    def find_collaborator_public_profile(collaborator_id)
      scope.includes(:badges).find_by({ id: collaborator_id })
    end

  def self.collaborators_pool_directory
    # TODO: This list of id's is just temporally, will be replaced
    public_profiles_ids = [1, 2, 3, 4, 5, 6, 7, 100, 101, 102, 103]
    scope.select([:id, :profile, :position, :nickname]).where({ id: public_profiles_ids })
  end
end
