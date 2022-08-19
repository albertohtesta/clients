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

    def collaborators_pool_directory
      # TODO: This list of id's is just temporally, will be replaced
      public_profiles_ids = [1, 2, 3, 4, 5, 6, 7, 200, 201, 202, 203]
      scope.select([:id, :profile, :position, :nickname, :uuid]).where({ id: public_profiles_ids })
    end

    def filter_by_category(category)
      collaborators_pool_directory.where({ category: })
    end
  end
end
